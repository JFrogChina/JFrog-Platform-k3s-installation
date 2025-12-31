# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

# platform
kubectl delete pod/jfrog-platform-artifactory-0 -n $NAMESPACE

# art
kubectl delete pod/artifactory-0 -n $NAMESPACE



