
# include common
source common.sh

echo
echo "install jfrog start"
echo "****************************************************"

kubectl create namespace jp

# create secret (not used, not work with jfrog-platform chart)
# kubectl create secret generic art-system-yaml -n jp --from-file=system.yaml=./art-system.yaml
# kubectl create secret generic xray-system-yaml -n jp --from-file=system.yaml=./xray-system.yaml

# create pv (not used, not work with jfrog-platform chart)
# export HOST_PATH=$K3S_DATA_DIR
# envsubst < ./pv.yaml | kubectl apply -n jp -f -
# kubectl apply -n jp -f ./pvc.yaml

# install / upgrade
# NOTICE
cd $DOWNLOAD_DIR_JFROG
helm upgrade --install jfrog-platform --namespace jp ./jfrog-platform-$JFROG_CHART_VERSION.tgz -f custom-values.yaml

echo
echo "check pv"
kubectl get pv -n jp

echo
echo "install jfrog end "
echo "****************************************************"

