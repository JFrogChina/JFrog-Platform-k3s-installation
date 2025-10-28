#!/bin/bash
# bash is required by (envsubst < ./custom/external-db.yaml)

# include common
source common.sh

echo
echo "install jfrog-platform start"
echo "****************************************************"

kubectl create namespace $NAMESPACE

# create secret (not used, not work with jfrog-platform chart)
# kubectl create secret generic art-system-yaml -n $NAMESPACE --from-file=system.yaml=./art-system.yaml
# kubectl create secret generic xray-system-yaml -n $NAMESPACE --from-file=system.yaml=./xray-system.yaml

# create pv (not used, not work with jfrog-platform chart)
# export HOST_PATH=$K3S_DATA_DIR
# envsubst < ./pv.yaml | kubectl apply -n $NAMESPACE -f -
# kubectl apply -n $NAMESPACE -f ./pvc.yaml

# install / upgrade

cd $DOWNLOAD_DIR_JFROG

echo
echo "by default, an internal database will be created in the same namespace"
echo
echo "to use an external database, you can"
echo "1. use ./pg-install.sh, ./pg-create-db.sh to create a database in another namespace"
echo "2. check $DOWNLOAD_DIR_JFROG/custom/external-db.yaml"
echo "3. set the environment variables PG_HOST and KFS_PASSWORD"
echo "4. ./3-install-jfrog-platform.sh"

echo
echo "use the internal database? (y/n, default is y)"

read -r choice
if [ -z "$choice" ] || [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    echo "you have chosen y"
    helm upgrade --install jfrog-platform --namespace $NAMESPACE ./jfrog-platform-$JFROG_PLATFORM_CHART_VERSION.tgz -f ./custom/jfrog-platform-custom-values.yaml
else
    echo "you have chosen n"
    echo
    : "${PG_HOST:?PG_HOST is required}"
    : "${KFS_PASSWORD:?KFS_PASSWORD is required}"

    helm upgrade --install jfrog-platform --namespace $NAMESPACE ./jfrog-platform-$JFROG_PLATFORM_CHART_VERSION.tgz -f ./custom/jfrog-platform-custom-values.yaml \
    -f <(envsubst < ./custom/external-db.yaml)
fi

echo
echo "check pv"
kubectl get pv

echo
echo "install jfrog-platform end "
echo "****************************************************"

