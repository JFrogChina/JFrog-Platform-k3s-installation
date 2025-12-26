# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh

kubectl delete pod -n $NAMESPACE -l app=runtime




