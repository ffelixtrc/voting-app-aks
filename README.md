APLICATIVO DE VOTAÇÂO

Foi criado o repositório de nome voting-app-aks para a o deploy do Cluster e aplicação no Azure.

Foram configuradas as Secrets que vão ser usadas no repositório para o Github Actions.

Foi feito o Git Clone do reposítorio localmente.

Com o terraform já configurado no WSL, foram criados os arquivos do deploy.

- providers.tf
- ssh.tf
- main.tf
- variables.tf
- outputs.tf

Iniciando o terraform.

terradorm init

Foi executado o plano de execução.

terraform plan

Aplicando o plano de execução.

terraform apply 

Após subir o cluster no azure, foi criado o arquivo voting-app.yaml no projeto do VScode para deploy da aplicação no cluster.

Conectamos ao Azure Cli para executar o comando de deploy da aplicação.

Az login

Utilizado o seguinte comando para obter o nome do grupo de recursos do Azure.

resource_group_name=$(terraform output -raw resource_group_name)

Executei o seguinte para identificar o nome do novo cluster.

az aks list \
  --subscription <subscription_id> \
  --resource-group $resource_group_name \
  --query "[].{\"K8s cluster name\":name}" \
  --output table

Obtendo a configuração do Kubernetes do estado Terraform e armazenando em um arquivo que o kubectl possa ler.

echo "$(terraform output kube_config)" > ./azurek8s

Checando se o comando anterior não gerou EOT no inicio e final do arquivo. Nos casos em que são gerados, nós removemos do arquivo.

cat ./azurek8s

Obtendo a configuração do Kubernetes do estado Terraform e armazenenando em um arquivo que o kubectl possa ler.

export KUBECONFIG=./azurek8s

Visualizando os nós do cluster.

kubectl get nodes

Aplicando o deploy do aplicativo cluster

kubectl apply -f voting-app.yaml

Para visualizar o IP externo de acesso ao aplicativo "deployado".

kubectl get service azure-vote-front --watch

Após ver o IP de acesso a aplicação na web, executei os comando Git:

Git init

Git commit -a

Git Push

O Git push gerou um erro referente a arquivos grandes não permitidos no Github. 

Usei o seguinte comando para resolver o erro mencionado.

git filter-branch -f --index-filter 'git rm --cached -r --ignore-unmatch .terraform/'

git push -f origin main



O aplicativo de votação que está rodando no cluster está acessivel em:

http://20.237.83.204

ou

http://votacao.felix.trc.br


Foi criado o manifesto voting-app-hpa.yaml para aplicação do HPA.
Ele está configurado para acrescentar até 10 réplicas baseando-se em uso de CPU, onde ao 
atingir 50% de uso do processamento, novas réplicas são criadas..
