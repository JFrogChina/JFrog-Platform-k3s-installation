# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

kubectl logs -n $NAMESPACE deploy/ingress-nginx-controller | tail -n 50
