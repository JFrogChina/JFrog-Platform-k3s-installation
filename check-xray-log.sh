
# include common
source common.sh

kubectl logs -f pod/jfrog-platform-xray-0 -c xray-server -n $NAMESPACE
kubectl logs -f pod/xray-0 -c xray-server -n $NAMESPACE
