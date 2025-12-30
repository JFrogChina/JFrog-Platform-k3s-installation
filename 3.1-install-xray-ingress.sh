
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

echo
echo "install xray ingress start"
echo "****************************************************"

cd $DOWNLOAD_DIR_JFROG
kubectl apply -f ./custom/xray-ingress.yaml --namespace $NAMESPACE

echo
echo "install xray ingress end "
echo "****************************************************"
