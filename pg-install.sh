
# include common
source common.sh

echo
echo "install pg"
echo "****************************************************"

echo
echo "KFS_PASSWORD=$KFS_PASSWORD"

if [ -z "$KFS_PASSWORD" ]; then
  echo "❌ KFS_PASSWORD not found, please set and try again"
  exit 1
fi

helm repo add bitnami https://charts.bitnami.com/bitnami
# helm repo update
# helm search repo bitnami/postgresql --versions | head
# helm pull bitnami/postgresql --version 13.2.24

echo
kubectl create namespace $NAMESPACE-pg

echo
helm upgrade --install postgresql \
--set auth.postgresPassword=$KFS_PASSWORD \
--set primary.persistence.size=300Gi \
--set primary.service.type=NodePort \
--set primary.service.nodePorts.postgresql=30432 \
--namespace $NAMESPACE-pg \
bitnami/postgresql --version 13.2.24 #--set-string primary.nodeSelector.kfs_pg=true
# upgrade will not remove the nodeSelector

export NODE_IP=$(kubectl get nodes --namespace $NAMESPACE-pg -o jsonpath="{.items[0].status.addresses[0].address}")
export NODE_PORT=$(kubectl get --namespace $NAMESPACE-pg -o jsonpath="{.spec.ports[0].nodePort}" services postgresql)

echo
echo "NODE_IP=$NODE_IP"
echo "NODE_PORT=$NODE_PORT"

echo "****************************************************"
echo "if connect from outside, the $NODE_IP is private IP, connect by SSH tunnel!"
echo "PGPASSWORD="$KFS_PASSWORD" psql --host $NODE_IP --port $NODE_PORT -U postgres -d postgres"
echo "****************************************************"

# check
kubectl get pod -n $NAMESPACE-pg

# if Failed to pull image "docker.io/bitnami/postgresql:16.1.0-debian-11-r15

# check node
# kubectl get pod -n $NAMESPACE-pg -o wide

# login node
# ssh $NODE_IP

# pull image
# ctr -n k8s.io image pull --user kyle soleng.jfrog.io/app1-docker-hub-remote/bitnami/postgresql:16.1.0-debian-11-r15
# ctr -n k8s.io images list
# ctr -n k8s.io images tag soleng.jfrog.io/app1-docker-hub-remote/bitnami/postgresql:16.1.0-debian-11-r15 docker.io/bitnami/postgresql:16.1.0-debian-11-r15

# label node
# kubectl label node cn-beijing.172.17.147.47 kfs_pg=true

# if delete label
# kubectl label node cn-beijing.172.17.147.47 kfs_pg-

# select node
# helm upgrade ... --set-string primary.nodeSelector.kfs_pg=true
