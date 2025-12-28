
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/../common.sh

echo
echo "install runtime service start"
echo "****************************************************"

cd $DOWNLOAD_DIR_JFROG
helm upgrade --install runtime --namespace "$NAMESPACE" ./runtime-service-$RUNTIME_SERVICE_CHART_VERSION.tgz -f ./custom/runtime-service-custom-values.yaml

echo
echo "check pv"
kubectl get pv -n $NAMESPACE

echo
echo "install runtime service end "
echo "****************************************************"
