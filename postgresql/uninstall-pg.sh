
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/../common.sh

echo
echo "uninstall pg start"
echo "****************************************************"

PG_NAMESPACE=$NAMESPACE-pg

echo 
echo "PG_NAMESPACE=$PG_NAMESPACE"

echo
echo "1. stop pg"
echo "----------------------------------------------------"
echo "pvc/pv will retain, xraydb data will retain, secret will be deleted"

echo "uninstall pg"
helm uninstall postgresql --namespace $PG_NAMESPACE

echo
echo "2. delete namespace $PG_NAMESPACE"
echo "----------------------------------------------------"

echo "delete namespace $PG_NAMESPACE (all data will be lost)? (y/n, default is n)"
read -r choice
if [ -z "$choice" ] || [ "$choice" = "n" ] || [ "$choice" = "N" ]; then
    echo "you have chosen n"
    echo "not to delete"
else
    echo "you have chosen y"
    echo "delete namespace, please wait ..."
    # all will lost
    kubectl delete ns $PG_NAMESPACE
fi

echo
echo "uninstall jfrog end"
echo "****************************************************"


