#!/bin/bash
# bash is required by (envsubst < ./custom/external-pg.yaml)

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

if [ "$#" -eq 0 ]; then
    helm upgrade --install jfrog-platform --namespace $NAMESPACE ./jfrog-platform-$JFROG_PLATFORM_CHART_VERSION.tgz -f ./custom/jfrog-platform-custom-values.yaml
else
    for item in "$@"; do
        case "$item" in
            ex-db)

                echo
                : "${PG_HOST:?PG_HOST is required}"
                : "${KFS_PASSWORD:?KFS_PASSWORD is required}"

                helm upgrade --install jfrog-platform --namespace $NAMESPACE ./jfrog-platform-$JFROG_PLATFORM_CHART_VERSION.tgz -f ./custom/jfrog-platform-custom-values.yaml \
                -f <(envsubst < ./custom/external-pg.yaml)

                ;;
            xxx)
                echo "param: $item"
                ;;
            *)
                echo "⚠️ invalid param: $item, skip"
                ;;
        esac
    done
fi

echo
echo "check pv"
kubectl get pv -n $NAMESPACE

echo
echo "install jfrog-platform end "
echo "****************************************************"

