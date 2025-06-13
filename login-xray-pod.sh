

kubectl exec --stdin --tty jfrog-platform-xray-0 -n jp -- /bin/bash

# after login

# e.g.
# ls ./var/etc/
# cat ./var/etc/system.yaml

# ls ./var/log/
# tail ./var/log/xray-server-service.log -f
