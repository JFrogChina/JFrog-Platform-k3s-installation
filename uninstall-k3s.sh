
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

echo
echo "uninstall k3s start"
echo "****************************************************"

echo
echo "1. stop k3s"
echo "----------------------------------------------------"
/usr/local/bin/k3s-killall.sh

echo
echo "2. uninstall k3s"
echo "----------------------------------------------------"
/usr/local/bin/k3s-uninstall.sh

echo
echo "3. clear k3s data dir"
echo "----------------------------------------------------"
# https://mrkandreev.name/snippets/how_to_move_k3s_data_to_another_location/
# https://www.davidprat.com/k3s-etcd-backups-and-snapshots-explained/
echo "clear k3s data dir? (y/n, default is y)"
read -r choice
    
if [ -z "$choice" ] || [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    echo "you have chosen y"
    rm -rf $K3S_DATA_DIR/*
    echo "cleared"
else
    echo "you have chosen n"
fi

echo
echo "uninstall k3s end"
echo "****************************************************"
echo "*          kfs = k3s + jfrog platform!             *"
echo "*  Notice: If you want to reinstall,               *"
echo "*  please start again by executing ./1-download.sh *"
echo "****************************************************"





