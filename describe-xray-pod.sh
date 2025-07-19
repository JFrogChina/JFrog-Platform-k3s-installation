
# include common
source common.sh

kubectl describe pod/jfrog-platform-xray-0 -n $NAMESPACE

