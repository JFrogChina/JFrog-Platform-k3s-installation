
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh

echo
echo "install runtime ingress controller start"
echo "****************************************************"

cd $DOWNLOAD_DIR_JFROG
helm install ingress-nginx --namespace "$NAMESPACE" ./ingress-nginx-$RUNTIME_INGRESS_CHART_VERSION.tgz \
  --set controller.service.type=NodePort \
  --set controller.service.ports.http=8080 \
  --set controller.service.ports.https=8443

echo
echo "install runtime ingress controller end "
echo "****************************************************"

# ./check-pod.sh
# ingress-nginx-controller-c5d55b5b5-mr2bj   1/1     Running

# ./check-svc.sh
# ingress-nginx-controller             NodePort    10.43.35.117    <none>        8080:30985/TCP,8443:32348/TCP 

