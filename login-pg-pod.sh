# include common
source common.sh


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






