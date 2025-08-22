
# include common
source common.sh

POD_PREFIX=jfrog-platform-catalog

POD_NAME=$(kubectl get pods -n $NAMESPACE \
  | grep "^$POD_PREFIX" \
  | awk '{print $1}' \
  | head -n 1)

if [ -z "$POD_NAME" ]; then
  echo "cannot find Pod: $POD_PREFIX"
  exit 1
fi

echo "checking log of Pod: $POD_NAME"
kubectl logs -f pod/$POD_NAME -n $NAMESPACE

# also check health by browser
# curl http://x.x.x.x:8080/catalog/api/v1/system/app_health

# {
#     "entitlements": {
#         "entitled_for_catalog": true,
#         "has_central_token": true,
#         "token_expired": false,
#         "token_expiration": "2025-08-22T16:22:10Z"
#     },
#     "central": {
#         "central_connection_working": true,
#         "central_node": "catalog-central-584fbf78b-kv4vw"
#     },
#     "db_connection_working": true,
#     "one_model_available": true,
#     "code": "OK"
# }
