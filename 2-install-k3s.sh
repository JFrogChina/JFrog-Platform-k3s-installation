
# include common
source common.sh

echo
echo "install k3s start"
echo "****************************************************"

# checkm system
echo
echo "1. check system"
echo "----------------------------------------------------"
free -h
df -h
sestatus

echo
echo "2. install k3s"
echo "----------------------------------------------------"
# install k3s
cd $DOWNLOAD_DIR_K3S
INSTALL_K3S_SKIP_DOWNLOAD=true ./install.sh --data-dir=$K3S_DATA_DIR

# check (kubectl installed by k3s)
kubectl get node

# copy config for helm                      
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config


echo
echo "3. import jfrog images"
echo "----------------------------------------------------"
# https://cwienczek.com/2020/06/import-images-to-k3s-without-docker-registry/
file_path="$DOWNLOAD_DIR_JFROG/jfrog-images.tar"

if [ -f "$file_path" ]; then
    echo "file found in local: $file_path"

    echo "import jfrog images? (y/n)"
    read -r choice
    if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
        echo "import jfrog, please wait ..."
        ctr images import $file_path
    else
        echo "not to import"
    fi
else
    echo "file not found, will pull from network when install by helm chart"
fi


echo
echo "k3s containers running"
ctr containers list

# list images
# ctr images list -q | grep jfrog

echo
echo "install k3s end"
echo "****************************************************"


