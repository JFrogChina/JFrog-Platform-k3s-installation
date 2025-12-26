
# include common
source common.sh

# 1. kill port forward to nginx
$APP_DIR/kill-kubectl.sh

# 2. upgrade artifactory to disable nginx & enable ingress
echo
echo "to install runtime, first need to upgrade artifactory"
echo "check $DOWNLOAD_DIR_JFROG/custom/jfrog-platform-custom-values.yaml / art-custom-values.yaml"
echo "1. disable its nginx"
echo "2. enable its ingress"
echo "3. upgrade artifactory by 3-install-xxx.sh"
echo 







