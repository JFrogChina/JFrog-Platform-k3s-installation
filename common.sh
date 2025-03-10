echo
echo "kfs common start"
echo "****************************************************"

# xray has bug in this version
# JFROG_CHART_VERSION=10.19.6 

# verified this version works
JFROG_CHART_VERSION=10.20.0

# this version has catalog
# JFROG_CHART_VERSION=11.0.3

echo "JFROG_CHART_VERSION is $JFROG_CHART_VERSION"
echo

# kfs path
SHELL_DIR=$(dirname "$BASH_SOURCE")

APP_DIR=$(cd $SHELL_DIR; pwd)

DOWNLOAD_DIR=$APP_DIR/download
DOWNLOAD_DIR_K3S=$APP_DIR/download/k3s
DOWNLOAD_DIR_HELM=$APP_DIR/download/helm
DOWNLOAD_DIR_JFROG=$APP_DIR/download/jfrog

K3S_DATA_DIR=$APP_DIR/k3s-data-dir
# make sure dir exists, possible not included when packaging
mkdir -p $K3S_DATA_DIR
mkdir -p $K3S_DATA_DIR/agent/images/

echo "APP_DIR is $APP_DIR"
echo "DOWNLOAD_DIR is $DOWNLOAD_DIR"
echo "K3S_DATA_DIR is $K3S_DATA_DIR"

echo
echo "kfs common end"
echo "****************************************************"

