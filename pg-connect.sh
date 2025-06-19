
# include common
source common.sh

echo
echo "connect pg"
echo "****************************************************"

# connect
kubectl run postgresql-client \
  --rm --tty -i \
  --restart='Never' \
  --namespace $NAMESPACE-pg \
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

