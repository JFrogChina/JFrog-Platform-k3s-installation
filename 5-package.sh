
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

echo
echo "package start"
echo "****************************************************"

echo
echo "1. export jfrog images"
echo "----------------------------------------------------"

JFROG_IMAGES_PATH=$DOWNLOAD_DIR_JFROG/jfrog-images.tar
echo "check exported jfrog"
du -sh $JFROG_IMAGES_PATH

echo "export jfrog images? (y/n, default is y)"
read -r choice
if [ -z "$choice" ] || [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    echo "you have chosen y"
    echo "export jfrog images, please wait ..."
    # helm install jfrog helps us pull the images, no need to install docker to do that
    JFROG_IMAGES_NAME=`kubectl get pods -n $NAMESPACE -o jsonpath="{..image}"`
    ctr images export $JFROG_IMAGES_PATH $JFROG_IMAGES_NAME
else
    echo "you have chosen n"
    echo "not to export"
fi
du -sh $JFROG_IMAGES_PATH


KFS_PACKAGE_PATH=~/kfs.tar.gz
echo
echo "2. package kfs to $KFS_PACKAGE_PATH"
echo "----------------------------------------------------"

cd $KFS_DIR
cd ..    

echo "include k3s data dir? (y/n, default is n)"
du -sh $K3S_DATA_DIR

read -r choice
if [ -z "$choice" ] || [ "$choice" = "n" ] || [ "$choice" = "N" ]; then
    echo "you have chosen n"
    echo "not to include"
    tar --exclude=$K3S_DATA_DIR --exclude-vcs -czvf $KFS_PACKAGE_PATH $KFS_DIR
else
    echo "you have chosen y"
    tar --exclude-vcs -czvf $KFS_PACKAGE_PATH $KFS_DIR
fi

echo
du -sh $KFS_PACKAGE_PATH

echo
echo "package end"
echo "****************************************************"

# upload to another server to test (private ip is fast)
# e.g.
# scp ~/kfs.tar.gz root@172.24.28.130:/root/




