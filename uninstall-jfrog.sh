
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

echo
echo "uninstall jfrog start"
echo "****************************************************"

echo
echo "1. stop jfrog"
echo "----------------------------------------------------"
echo "pvc/pv will retain, xraydb data will retain, secret will be deleted"

echo "uninstall jfrog-platform"
helm uninstall jfrog-platform --namespace $NAMESPACE

echo "uninstall artifactory"
helm uninstall artifactory --namespace $NAMESPACE

echo "uninstall xray"
helm uninstall xray --namespace $NAMESPACE

# if manual created pv/pvc
# if error = storageclass.storage.k8s.io "manual" not found, do delete pv/pvc e.g. kubectl delete pv/pv-pg -n $NAMESPACE
# kubectl delete pvc/pvc-pg -n $NAMESPACE
# kubectl delete pvc/pvc-rabbit -n $NAMESPACE
# kubectl delete pvc/pvc-art -n $NAMESPACE
# kubectl delete pvc/pvc-xray -n $NAMESPACE

# kubectl delete pv/pv-pg -n $NAMESPACE
# kubectl delete pv/pv-rabbit -n $NAMESPACE
# kubectl delete pv/pv-art -n $NAMESPACE
# kubectl delete pv/pv-xray -n $NAMESPACE

echo
echo "2. delete namespace $NAMESPACE"
echo "----------------------------------------------------"

echo "delete namespace $NAMESPACE (all data will be lost)? (y/n, default is n)"
read -r choice
if [ -z "$choice" ] || [ "$choice" = "n" ] || [ "$choice" = "N" ]; then
    echo "you have chosen n"
    echo "not to delete"
else
    echo "you have chosen y"
    echo "delete namespace, please wait ..."
    # all will lost
    kubectl delete ns $NAMESPACE
fi

echo
echo "uninstall jfrog end"
echo "****************************************************"


