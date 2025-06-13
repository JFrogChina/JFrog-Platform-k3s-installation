
# include common
source common.sh

kubectl logs -f pod/jfrog-platform-artifactory-0 -c artifactory -n $NAMESPACE
kubectl logs -f pod/artifactory-0 -c artifactory -n $NAMESPACE

