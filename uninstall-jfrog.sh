
# include common
source common.sh

echo
echo "uninstall jfrog start"
echo "****************************************************"

echo
echo "1. stop jfrog"
echo "----------------------------------------------------"
# pvc will retain, secret will lost

echo "uninstall jfrog-platform"
helm uninstall jfrog-platform --namespace jp

echo "uninstall artifactory"
helm uninstall artifactory --namespace jp

echo "uninstall xray"
helm uninstall xray --namespace jp

# manual pv/pvc (not used, because jfrog's chart's existingClaim not work)
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


