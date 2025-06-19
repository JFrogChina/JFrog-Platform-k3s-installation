
# include common
source common.sh

echo
echo "install artifactory start"
echo "****************************************************"

kubectl create namespace jp

# install / upgrade

cd $DOWNLOAD_DIR_JFROG
helm upgrade --install artifactory --namespace jp ./artifactory-$ART_CHART_VERSION.tgz -f ./custom/art-custom-values.yaml
# --set postgresql.enabled=false \
# --set database.type="postgresql" \
# --set database.driver="org.postgresql.Driver" \
# --set database.url="jdbc:postgresql://$PG_HOST:5432/kfs_artifactory" \
# --set database.user="kfs_user" \
# --set database.password="$KFS_PASSWORD"

echo
echo "check pv"
kubectl get pv -n $NAMESPACE

echo
echo "install artifactory end "
echo "****************************************************"

