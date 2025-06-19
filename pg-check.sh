
# include common
source common.sh

echo
# kubectl describe pod postgresql-0 -n $NAMESPACE-pg

echo
kubectl get pod -n $NAMESPACE-pg -o wide

echo
echo "NODE_IP=$NODE_IP"
echo "NODE_PORT=$NODE_PORT"
echo



