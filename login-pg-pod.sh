# include common
source common.sh


kubectl exec --stdin --tty jfrog-platform-postgresql-0 -n $NAMESPACE -- /bin/bash

# after login

# e.g.
# df -h
# du -sh /bitnami/postgresql/data/



