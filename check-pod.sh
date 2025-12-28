# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

echo "kubectl get pod -n $NAMESPACE"
kubectl get pod -n $NAMESPACE


