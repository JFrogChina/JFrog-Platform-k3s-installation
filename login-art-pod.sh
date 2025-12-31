# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

# platform
kubectl exec --stdin --tty jfrog-platform-artifactory-0 -n $NAMESPACE -- /bin/bash

# art
kubectl exec --stdin --tty artifactory-0 -n $NAMESPACE -- /bin/bash

# after login

# e.g.
# ls ./var/etc/
# cat ./var/etc/system.yaml

# ls ./var/log/
# tail ./var/log/artifactory-service.log -f




