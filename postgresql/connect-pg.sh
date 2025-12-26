
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh

echo
echo "connect pg"
echo "****************************************************"

PG_NAMESPACE=$NAMESPACE-pg

echo 
echo "PG_NAMESPACE=$PG_NAMESPACE"

# connect
kubectl run postgresql-client \
  --rm --tty -i \
  --restart='Never' \
  --namespace $PG_NAMESPACE \
  --image docker.io/bitnami/postgresql:16.1.0-debian-11-r15 \
  --env="PGPASSWORD=$KFS_PASSWORD" \
  --overrides='{
    "apiVersion": "v1",
    "spec": {
      "nodeSelector": {
        "kfs_pg": "true"
      }
    }
  }' \
  --command -- psql --host postgresql -U postgres -d postgres -p 5432

