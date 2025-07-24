
# include common
source common.sh

echo
echo "create db"
echo "****************************************************"

PG_NAMESPACE=$NAMESPACE-pg

echo 
echo "PG_NAMESPACE=$PG_NAMESPACE"

SQL="
CREATE USER kfs_user WITH PASSWORD '$KFS_PASSWORD';
CREATE DATABASE kfs_artifactory WITH OWNER=kfs_user ENCODING='UTF8';
GRANT ALL PRIVILEGES ON DATABASE kfs_artifactory TO kfs_user;
CREATE DATABASE kfs_xray WITH OWNER=kfs_user ENCODING='UTF8';
GRANT ALL PRIVILEGES ON DATABASE kfs_xray TO kfs_user;
"

kubectl run postgresql-client \
  --rm -i --tty \
  --restart='Never' \
  --namespace "$PG_NAMESPACE" \
  --image=docker.io/bitnami/postgresql:16.1.0-debian-11-r15 \
  --env="PGPASSWORD=$KFS_PASSWORD" \
  --overrides='{
    "apiVersion": "v1",
    "spec": {
      "nodeSelector": {
        "kfs_pg": "true"
      }
    }
  }' \
  -- bash -c "echo \"$SQL\" | psql -h postgresql -U postgres -d postgres -p 5432"

