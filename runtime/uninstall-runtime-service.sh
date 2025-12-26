
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh

echo
echo "uninstall runtime controller start"
echo "****************************************************"

cd $DOWNLOAD_DIR_JFROG
helm uninstall runtime --namespace "$NAMESPACE" ./runtime-service-$RUNTIME_SERVICE_CHART_VERSION.tgz

echo
echo "uninstall runtime controller end"
echo "****************************************************"


