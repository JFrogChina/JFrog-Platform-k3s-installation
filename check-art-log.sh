# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

kubectl logs -f pod/jfrog-platform-artifactory-0 -c artifactory -n $NAMESPACE
kubectl logs -f pod/artifactory-0 -c artifactory -n $NAMESPACE

