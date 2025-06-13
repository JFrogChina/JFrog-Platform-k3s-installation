
# include common
source common.sh

echo
echo "install artifactory start"
echo "****************************************************"

kubectl create namespace jp

# install / upgrade
# NOTICE
cd $DOWNLOAD_DIR_JFROG
helm upgrade --install artifactory --namespace jp ./artifactory-$ART_CHART_VERSION.tgz -f ./custom/art-custom-values.yaml

echo
echo "check pv"
kubectl get pv -n jp

echo
echo "install artifactory end "
echo "****************************************************"

