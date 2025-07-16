
# include common
source common.sh

echo
echo "config nginx tls"
echo "****************************************************"

echo "1. create tls secret"
cd $DOWNLOAD_DIR_JFROG
kubectl create secret tls my-tls -n $NAMESPACE --cert=./custom/xxx.com.pem --key=./custom/xxx.com.key

# check ./custom/xxx-values-custom.yaml > tlsSecretName: my-tls

echo "2. please upgrade by ./3-install-xxx.sh"

