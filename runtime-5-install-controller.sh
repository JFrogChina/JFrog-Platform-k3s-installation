
# include common
source common.sh

echo
echo "install runtime controller start"
echo "****************************************************"


echo
    : "${REGISTRATION_TOKEN:?REGISTRATION_TOKEN is required, get it from admin > runtime settings > cluster management}"

# use NODE_IP of nginx ingress, which has gRPC required by runtime
export NODE_IP=$(kubectl get nodes --namespace $NAMESPACE -o jsonpath="{.items[0].status.addresses[0].address}")

cd $DOWNLOAD_DIR_JFROG
helm upgrade --install jf-sensors --namespace "$NAMESPACE" ./runtime-sensors-$RUNTIME_SENSORS_CHART_VERSION.tgz -f ./custom/runtime-controller-custom-values.yaml \
 --set sensors.enabled=true \
 --set clusterName=kfs \
 --set jfrogUrl=$NODE_IP:8443 \
 --set tlsInsecureSkipVerify=true \
 --set registrationToken=${REGISTRATION_TOKEN};

# todo
# Error with trying to send data: rpc error: code = Unauthenticated desc = Unauthorized; Bearer authorization token is empty

echo
echo "install runtime controller end "
echo "****************************************************"

