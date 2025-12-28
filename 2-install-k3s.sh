
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

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

# redhat 10 on ali cloud
systemctl stop nm-cloud-setup.service
systemctl disable nm-cloud-setup.service


echo
echo "2. install k3s"
echo "----------------------------------------------------"
# install k3s
cd $DOWNLOAD_DIR_K3S
INSTALL_K3S_SKIP_DOWNLOAD=true ./install.sh --data-dir=$K3S_DATA_DIR

# check (kubectl installed by k3s)
kubectl get node

echo
echo "3. config k3s"
echo "----------------------------------------------------"
cd $DOWNLOAD_DIR_K3S

echo "copy config to ~/.kube/config for helm"
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

echo "if pull image from internet, do the whitelist & test:"
echo "curl releases-docker.jfrog.io"
echo "curl releases-cdn.jfrog.io"

echo "skip tls verify for pulling image from internet"
cp ./custom/registries.yaml /etc/rancher/k3s/

echo
echo "4. import jfrog images"
echo "----------------------------------------------------"
# https://cwienczek.com/2020/06/import-images-to-k3s-without-docker-registry/
file_path="$DOWNLOAD_DIR_JFROG/jfrog-images.tar"

if [ -f "$file_path" ]; then
    echo "file found in local: $file_path"

    echo "import jfrog images? (y/n, default is y)"
    read -r choice
    if [ -z "$choice" ] || [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
        echo "you have chosen y"
        echo "import jfrog, please wait ..."
        ctr images import $file_path
    else
        echo "you have chosen n"
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


