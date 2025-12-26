# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh


kubectl exec --stdin --tty jfrog-platform-postgresql-0 -n $NAMESPACE -- /bin/bash


# after login
# df -h
# du -sh /bitnami/postgresql/data/


# default
# postgresqlUsername: postgres
# postgresqlPassword: postgres

# user: artifactory
# password: artifactory

# user: xray
# password: xray

# e.g.
# psql -U xray -d xray -p 5432






