
# include common
source common.sh

echo
echo "install xray start"
echo "****************************************************"

kubectl create namespace jp

# install / upgrade
# NOTICE
cd $DOWNLOAD_DIR_JFROG
helm upgrade --install xray --namespace jp ./xray-$XRAY_CHART_VERSION.tgz -f ./custom/xray-custom-values.yaml

echo
echo "check pv"
kubectl get pv -n jp

echo
echo "install xray end "
echo "****************************************************"

