# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

kubectl exec --stdin --tty jfrog-platform-xray-0 -n $NAMESPACE -- /bin/bash

# after login

# e.g.
# ls ./var/etc/
# cat ./var/etc/system.yaml

# ls ./var/log/
# tail ./var/log/xray-server-service.log -f
