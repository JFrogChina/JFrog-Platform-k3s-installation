
# include common
source common.sh

echo
echo "create tls secret"
echo "****************************************************"

cd $DOWNLOAD_DIR_JFROG
kubectl create secret tls my-tls -n $NAMESPACE --cert=./custom/xxx.com.pem --key=./custom/xxx.com.key

# check ./custom/xxx-values-custom.yaml > tlsSecretName: my-tls

