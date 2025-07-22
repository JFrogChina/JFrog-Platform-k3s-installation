
# include common
source common.sh


# "JFROG_PLATFORM_CHART_VERSION": "10.20.0"
KUBECTL_VERSION=1.24.12

# "JFROG_PLATFORM_CHART_VERSION": "11.1.2"
# KUBECTL_VERSION=:1.31.2

# 1. check image

        # search 'kubectl' in values.yaml of chart
        
        # or check upgrade's error pod
        # e.g. kubectl describe pod/jfrog-platform-xxx-pre-xxx
        # releases-docker.jfrog.io/bitnami/kubectl:1.31.2

# 2. pull in internet vm

        ctr image pull releases-docker.jfrog.io/bitnami/kubectl:$KUBECTL_VERSION
        
# 3. export

        ctr image ls | grep kubectl
        ctr image export $DOWNLOAD_DIR_JFROG/kubectl_$KUBECTL_VERSION.tar releases-docker.jfrog.io/bitnami/kubectl:$KUBECTL_VERSION        



