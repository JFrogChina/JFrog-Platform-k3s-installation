
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh

PG_NAMESPACE=$NAMESPACE-pg

echo 
echo "PG_NAMESPACE=$PG_NAMESPACE"

echo
# kubectl describe pod postgresql-0 -n $PG_NAMESPACE

echo
kubectl get pod -n $PG_NAMESPACE -o wide

echo
echo "NODE_IP=$NODE_IP"
echo "NODE_PORT=$NODE_PORT"
echo



