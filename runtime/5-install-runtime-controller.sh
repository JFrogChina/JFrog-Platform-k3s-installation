
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/../common.sh

echo
echo "install runtime controller start"
echo "****************************************************"

echo
    : "${REGISTRATION_TOKEN:?REGISTRATION_TOKEN is required, get it from admin > runtime settings > cluster management}"

cd $DOWNLOAD_DIR_JFROG

# works by service name in same namespace
helm upgrade --install jf-sensors --namespace "$NAMESPACE" ./runtime-sensors-$RUNTIME_SENSORS_CHART_VERSION.tgz -f ./custom/runtime-controller-custom-values.yaml \
 --set sensors.enabled=true \
 --set clusterName=kfs \
 --set jfrogUrl=ingress-nginx-controller:8443 \
 --set tlsInsecureSkipVerify=true \
 --set registrationToken="$REGISTRATION_TOKEN";

# if try by domain
# 1. update ./custom/runtime-service-custom-values.yaml, relace "ingress-nginx-controller" with "xxx.xxx.com" (will be used as ingress host)
# 2. use domain as jfrogUrl, notice if jfrogUrl = http://xxx:8443, it will be http://xxx:8443:443 (bug)
# helm upgrade --install jf-sensors --namespace "$NAMESPACE" ./runtime-sensors-$RUNTIME_SENSORS_CHART_VERSION.tgz -f ./custom/runtime-controller-custom-values.yaml \
#  --set sensors.enabled=true \
#  --set clusterName=kfs \
#  --set jfrogUrl=https://xxx.xxx.com \
#  --set tlsInsecureSkipVerify=true \
#  --set registrationToken="$REGISTRATION_TOKEN";

echo
echo "install runtime controller end "
echo "****************************************************"

