
# include common
source common.sh


# "JFROG_PLATFORM_CHART_VERSION": "10.20.0"
KUBECTL_VERSION=1.24.12

# "JFROG_PLATFORM_CHART_VERSION": "11.1.2" / "11.2.0"
# KUBECTL_VERSION=:1.31.2

# 1. check image

        echo 
        echo "KUBECTL_VERSION=$KUBECTL_VERSION"
        echo "to update the version:"
        echo "search 'kubectl' in values.yaml of chart"
        echo 
        echo "or check upgrade's error pod"
        echo 
        echo "e.g. kubectl describe pod/jfrog-platform-xxx-pre-xxx"
        echo "releases-docker.jfrog.io/bitnami/kubectl:1.31.2"
        echo 

# 2. pull in internet vm

        ctr image pull releases-docker.jfrog.io/bitnami/kubectl:$KUBECTL_VERSION
        
# 3. export

        ctr image ls | grep kubectl
        ctr image export $DOWNLOAD_DIR_JFROG/kubectl_$KUBECTL_VERSION.tar releases-docker.jfrog.io/bitnami/kubectl:$KUBECTL_VERSION        

# 4. import in airgap vm

        ctr image import $DOWNLOAD_DIR_JFROG/kubectl_$KUBECTL_VERSION.tar

