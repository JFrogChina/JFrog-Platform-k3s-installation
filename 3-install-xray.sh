
# include common
source common.sh

echo
echo "install xray start"
echo "****************************************************"


JFROG_URL="$1"
JOIN_KEY="$2"

if [ -z "$JFROG_URL" ] || [ -z "$JOIN_KEY" ]; then
  echo
  echo "❌ error, missing params"
  echo "usage: $0 <JFROG_URL> <JOIN_KEY>"
  echo "e.g.   $0 https://jfrog.example.com my-join-key"
  echo
  exit 1
fi

echo "JFROG_URL = $JFROG_URL"
echo "JOIN_KEY = $JOIN_KEY"


# ensure namespace exists (idempotent)
kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

# install / upgrade
# NOTICE
cd $DOWNLOAD_DIR_JFROG
helm upgrade --install xray --namespace "$NAMESPACE" ./xray-$XRAY_CHART_VERSION.tgz -f ./custom/xray-custom-values.yaml \
--set xray.jfrogUrl="$JFROG_URL" \
--set xray.joinKey="$JOIN_KEY" 
# --set postgresql.enabled="false" \
# --set database.url="postgres://$PG_HOST:5432/kfs_xray?sslmode=disable" \
# --set database.user="kfs_user" \
# --set database.password="$KFS_PASSWORD"

echo
echo "check pv"
kubectl get pv -n $NAMESPACE

echo
echo "install xray end "
echo "****************************************************"
