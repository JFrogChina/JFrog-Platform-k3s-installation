
# include common
source common.sh

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


download_k3s() {
        echo
        echo "1. download k3s"
        echo "----------------------------------------------------"
        
        echo "K3S_ARCH=$K3S_ARCH"
        echo "K3S_VERSION=$K3S_VERSION"

        if [ -n "$K3S_ARCH" ] || [ -n "$K3S_VERSION" ]; then
            
            echo
            echo "1.1. download k3s binary"
            echo "----------------------------------------------------"

            file_path="$DOWNLOAD_DIR_K3S/k3s-airgap-images-$K3S_ARCH.tar.gz"
            download_url="https://github.com/k3s-io/k3s/releases/download/$K3S_VERSION%2Bk3s1/k3s-airgap-images-$K3S_ARCH.tar.gz"

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
            echo "1.2. download k3s binary"
            echo "----------------------------------------------------"

            file_path="$DOWNLOAD_DIR_K3S/k3s"
            download_url="https://github.com/k3s-io/k3s/releases/download/$K3S_VERSION%2Bk3s1/k3s"

            check_and_download_file $file_path $download_url

            if [ $? -eq 0 ]; then
                cp $file_path /usr/local/bin
                chmod +x /usr/local/bin/k3s
            else
                exit 1
            fi

            echo
            echo "1.3. download k3s script"
            echo "----------------------------------------------------"
            file_path="$DOWNLOAD_DIR_K3S/install.sh"
            download_url="https://get.k3s.io/"

            check_and_download_file $file_path $download_url

            if [ $? -eq 0 ]; then
                chmod +x $file_path
            else
                exit 1
            fi

        else
            echo "no k3s values defined, skip download"
        fi

}


download_helm() {
        echo
        echo "2. download helm"
        echo "----------------------------------------------------"
        
        echo "HELM_VERSION=$HELM_VERSION"
        echo "HELM_OS=$HELM_OS"
        echo "HELM_ARCH=$HELM_ARCH"

        if [ -n "$HELM_VERSION" ] || [ -n "$HELM_OS" ] || [ -n "$HELM_ARCH" ]; then
            
            file_path="$DOWNLOAD_DIR_HELM/helm-$HELM_VERSION-$HELM_OS-$HELM_ARCH.tar.gz"
            download_url="https://get.helm.sh/helm-$HELM_VERSION-$HELM_OS-$HELM_ARCH.tar.gz"

            check_and_download_file $file_path $download_url

            if [ $? -eq 0 ]; then
                tar -zxf $file_path -C $DOWNLOAD_DIR_HELM
                mv $DOWNLOAD_DIR_HELM/$HELM_OS-$HELM_ARCH/helm /usr/local/bin/helm
            else
                exit 1
            fi
        
        else
            echo "no helm values defined, skip download"
        fi
}


download_jfrog() {
        echo
        echo "3. download jfrog helm chart"
        echo "----------------------------------------------------"

        echo "JFROG_PLATFORM_CHART_VERSION=$JFROG_PLATFORM_CHART_VERSION"
        echo "ART_CHART_VERSION=$ART_CHART_VERSION"
        echo "XRAY_CHART_VERSION=$XRAY_CHART_VERSION"
        echo "RUNTIME_INGRESS_CHART_VERSION=$RUNTIME_INGRESS_CHART_VERSION"
        echo "RUNTIME_SERVICE_CHART_VERSION=$RUNTIME_SERVICE_CHART_VERSION"
        echo "RUNTIME_SENSORS_CHART_VERSION=$RUNTIME_SENSORS_CHART_VERSION"

        if [ -n "$JFROG_PLATFORM_CHART_VERSION" ] || [ -n "$ART_CHART_VERSION" ] || [ -n "$XRAY_CHART_VERSION" || [ -n "$RUNTIME_INGRESS_CHART_VERSION" || [ -n "$RUNTIME_SERVICE_CHART_VERSION" || [ -n "$RUNTIME_SENSORS_CHART_VERSION" ]; then
            
            # download jfrog-platform
            if [ -n "$JFROG_PLATFORM_CHART_VERSION" ]; then
                file_path="$DOWNLOAD_DIR_JFROG/jfrog-platform-$JFROG_PLATFORM_CHART_VERSION.tgz"

                if [ -f "$file_path" ]; then
                    echo "file found in local: $file_path"
                else
                    echo "$file_path not found, start download..."

                    echo "helm repo add & update jfrog - for jfrog-platform chart"
                    helm repo add jfrog https://charts.jfrog.io 
                    helm repo update jfrog

                    cd $DOWNLOAD_DIR_JFROG
                    helm pull jfrog/jfrog-platform --version=$JFROG_PLATFORM_CHART_VERSION
                fi
            fi

            # download artifactory
            if [ -n "$ART_CHART_VERSION" ]; then
                file_path="$DOWNLOAD_DIR_JFROG/artifactory-$ART_CHART_VERSION.tgz"

                if [ -f "$file_path" ]; then
                    echo "file found in local: $file_path"
                else
                    echo "$file_path not found, start download..."

                    echo "helm repo add & update jfrog - for art chart"
                    helm repo add jfrog https://charts.jfrog.io 
                    helm repo update jfrog

                    cd $DOWNLOAD_DIR_JFROG
                    helm pull jfrog/artifactory --version=$ART_CHART_VERSION
                fi
            fi

            # download xray
            if [ -n "$XRAY_CHART_VERSION" ]; then
                file_path="$DOWNLOAD_DIR_JFROG/xray-$XRAY_CHART_VERSION.tgz"

                if [ -f "$file_path" ]; then
                    echo "file found in local: $file_path"
                else
                    echo "$file_path not found, start download..."

                    echo "helm repo add & update jfrog - for xray chart"
                    helm repo add jfrog https://charts.jfrog.io 
                    helm repo update jfrog

                    cd $DOWNLOAD_DIR_JFROG
                    helm pull jfrog/xray --version=$XRAY_CHART_VERSION
                fi
            fi

            # download runtime ingress controller
            if [ -n "$RUNTIME_INGRESS_CHART_VERSION" ]; then
                file_path="$DOWNLOAD_DIR_JFROG/ingress-nginx-$RUNTIME_INGRESS_CHART_VERSION.tgz"

                if [ -f "$file_path" ]; then
                    echo "file found in local: $file_path"
                else
                    echo "$file_path not found, start download..."

                    # use chart from jfrog
                    # helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
                    echo "helm repo add & update jfrog - for runtime ingress controller chart"
                    helm repo add jfrog https://charts.jfrog.io 
                    helm repo update jfrog

                    # helm search repo ingress-nginx
                    # jfrog/ingress-nginx        	4.5.2        	1.6.4      	Ingress controller for Kubernetes using NGINX a...

                    cd $DOWNLOAD_DIR_JFROG
                    helm pull jfrog/ingress-nginx --version=$RUNTIME_INGRESS_CHART_VERSION
                fi
            fi

            # download runtime service
            if [ -n "$RUNTIME_SERVICE_CHART_VERSION" ]; then
                file_path="$DOWNLOAD_DIR_JFROG/runtime-service-$RUNTIME_SERVICE_CHART_VERSION.tgz"

                if [ -f "$file_path" ]; then
                    echo "file found in local: $file_path"
                else
                    echo "$file_path not found, start download..."

                    echo "helm repo add & update jfrog - for runtime chart"
                    helm repo add jfrog https://charts.jfrog.io 
                    helm repo update jfrog
                    # helm search repo jfrog/runtime
                    
                    # jfrog/runtime        	101.2.7      	1.2.7      	Runtime Security service                          
                    # jfrog/runtime-sensors	101.2.9      	1.2.9      	Helm chart for the deployment of JFrog Runtime ...

                    cd $DOWNLOAD_DIR_JFROG
                    helm pull jfrog/runtime --version=$RUNTIME_SERVICE_CHART_VERSION
                fi
            fi

            # download runtime sensors
            if [ -n "$RUNTIME_SENSORS_CHART_VERSION" ]; then
                file_path="$DOWNLOAD_DIR_JFROG/runtime-sensors-$RUNTIME_SENSORS_CHART_VERSION.tgz"

                if [ -f "$file_path" ]; then
                    echo "file found in local: $file_path"
                else
                    echo "$file_path not found, start download..."

                    echo "helm repo add & update jfrog - for runtime sensors chart"
                    helm repo add jfrog https://charts.jfrog.io 
                    helm repo update jfrog

                    cd $DOWNLOAD_DIR_JFROG
                    helm pull jfrog/runtime-sensors --version=$RUNTIME_SENSORS_CHART_VERSION
                fi
            fi

        else
            echo "no jfrog helm chart values defined, skip download"
        fi

}


echo
echo "download start"
echo "****************************************************"


if [ "$#" -eq 0 ]; then
    download_k3s
    download_helm
    download_jfrog
else
    for item in "$@"; do
        case "$item" in
            k3s)
                download_k3s
                ;;
            helm)
                download_helm
                ;;
            jfrog)
                download_jfrog
                ;;
            *)
                echo "⚠️ invalid param: $item, skip"
                ;;
        esac
    done
fi


echo
du -sh $DOWNLOAD_DIR

echo
echo "download end"
echo "****************************************************"




