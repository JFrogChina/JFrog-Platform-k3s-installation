

# include common
source common.sh

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
echo "clear k3s data dir? (y/n)"
read -r choice
    
if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    rm -rf $K3S_DATA_DIR/*
    echo "cleared"
fi

echo
echo "uninstall k3s end"
echo "****************************************************"





