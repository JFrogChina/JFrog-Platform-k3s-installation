# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

kubectl logs -f pod/jfrog-platform-xray-0 -c xray-server -n $NAMESPACE
kubectl logs -f pod/xray-0 -c xray-server -n $NAMESPACE
