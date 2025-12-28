# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/../common.sh

kubectl delete pod -n $NAMESPACE -l app=runtime




