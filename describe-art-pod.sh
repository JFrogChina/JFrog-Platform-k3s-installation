
# include common
source common.sh

kubectl describe pod/jfrog-platform-artifactory-0 -n $NAMESPACE

