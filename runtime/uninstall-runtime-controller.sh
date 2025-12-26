
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh

echo
echo "uninstall runtime controller start"
echo "****************************************************"

cd $DOWNLOAD_DIR_JFROG
helm uninstall jf-sensors --namespace "$NAMESPACE" ./runtime-sensors-$RUNTIME_SENSORS_CHART_VERSION.tgz

echo
echo "uninstall runtime controller end"
echo "****************************************************"


