

# include common
source common.sh

echo
echo "uninstall jfrog start"
echo "****************************************************"

echo
echo "1. stop jfrog"
echo "----------------------------------------------------"
# pvc will retain, secret will lost
helm uninstall jfrog-platform --namespace jp

# manual pv/pvc (not used, because jfrog's chart's existingClaim not work)
# if error = storageclass.storage.k8s.io "manual" not found, do delete pv/pvc e.g. kubectl delete pv/pv-pg -n jp
# kubectl delete pvc/pvc-pg -n jp
# kubectl delete pvc/pvc-rabbit -n jp
# kubectl delete pvc/pvc-art -n jp
# kubectl delete pvc/pvc-xray -n jp

# kubectl delete pv/pv-pg -n jp
# kubectl delete pv/pv-rabbit -n jp
# kubectl delete pv/pv-art -n jp
# kubectl delete pv/pv-xray -n jp

echo
echo "2. delete namespace jp"
echo "----------------------------------------------------"

echo "delete namespace jp (all data will be lost)? (y/n)"
read -r choice
if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    echo "delete namespace, please wait ..."
    # all will lost
    kubectl delete ns jp
else
    echo "not to delete"
fi

echo
echo "uninstall jfrog end"
echo "****************************************************"


