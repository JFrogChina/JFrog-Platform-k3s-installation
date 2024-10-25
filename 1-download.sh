
# include common
source common.sh

echo "****************************************************"
echo "*                kfs = k3s + frog!                 *"
echo "*  jfrog helm chart version=$JFROG_CHART_VERSION   *"
echo "****************************************************"

# function
check_and_download_file() {
    local file_path=$1
    local download_url=$2

    if [ -f "$file_path" ]; then
        echo "file found in local: $file_path"
        return 0 
    else
        echo "file not found, start download..."
        wget -O "$file_path" "$download_url"
        
        if [ $? -eq 0 ]; then
            echo "download success: $file_path"
            return 0 
        else
            echo "download failed"
            return 1 
        fi
    fi
}

echo
echo "download start"
echo "****************************************************"

echo
echo "1. download k3s images"
echo "----------------------------------------------------"
file_path="$DOWNLOAD_DIR_K3S/k3s-airgap-images-amd64.tar.gz"
download_url="https://github.com/k3s-io/k3s/releases/download/v1.24.10%2Bk3s1/k3s-airgap-images-amd64.tar.gz"

check_and_download_file $file_path $download_url

if [ $? -eq 0 ]; then
    # mkdir -p /var/lib/rancher/k3s/agent/images/
    # cp $file_path /var/lib/rancher/k3s/agent/images/

    # import images by placing into below path
    mkdir -p $K3S_DATA_DIR/agent/images/
    cp $file_path $K3S_DATA_DIR/agent/images/
else
    exit 1
fi

echo
echo "2. download k3s binary"
echo "----------------------------------------------------"

file_path="$DOWNLOAD_DIR_K3S/k3s"
download_url="https://github.com/k3s-io/k3s/releases/download/v1.24.10%2Bk3s1/k3s"

check_and_download_file $file_path $download_url

if [ $? -eq 0 ]; then
    cp $file_path /usr/local/bin
    chmod +x /usr/local/bin/k3s
else
    exit 1
fi

echo
echo "3. download k3s script"
echo "----------------------------------------------------"
file_path="$DOWNLOAD_DIR_K3S/install.sh"
download_url="https://get.k3s.io/"

check_and_download_file $file_path $download_url

if [ $? -eq 0 ]; then
    chmod +x $file_path
else
    exit 1
fi

echo
echo "4. download helm"
echo "----------------------------------------------------"
file_path="$DOWNLOAD_DIR_HELM/helm-v3.5.0-linux-amd64.tar.gz"
download_url="https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz"

check_and_download_file $file_path $download_url

if [ $? -eq 0 ]; then
    tar -zxf $file_path -C $DOWNLOAD_DIR_HELM
    mv $DOWNLOAD_DIR_HELM/linux-amd64/helm /usr/local/bin/helm
else
    exit 1
fi

echo
echo "5. download jfrog helm chart version=$JFROG_CHART_VERSION"
echo "----------------------------------------------------"
file_path="$DOWNLOAD_DIR_JFROG/jfrog-platform-$JFROG_CHART_VERSION.tgz"

if [ -f "$file_path" ]; then
    echo "file found in local: $file_path"
else
    echo "file not found, start download..."
    helm repo add jfrog https://charts.jfrog.io 
    helm repo update

    cd $DOWNLOAD_DIR_JFROG
    helm pull jfrog/jfrog-platform --version=$JFROG_CHART_VERSION
fi

echo
du -sh $DOWNLOAD_DIR

echo
echo "download end"
echo "****************************************************"




