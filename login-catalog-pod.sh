
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

kubectl exec --stdin --tty $POD_NAME -n $NAMESPACE -- /bin/bash

# after login

# e.g.
# cd /opt/jfrog/catalog/var/etc
# cat ./system.yaml


