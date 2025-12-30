# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

# platform
kubectl describe pod/jfrog-platform-xray-0 -n $NAMESPACE

# artifactory
kubectl describe pod/xray-0 -n $NAMESPACE
