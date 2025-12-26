
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh

POD_PREFIX=runtime

POD_NAME=$(kubectl get pods -n $NAMESPACE \
  | grep "^$POD_PREFIX" \
  | awk '{print $1}' \
  | head -n 1)

if [ -z "$POD_NAME" ]; then
  echo "cannot find Pod: $POD_PREFIX"
  exit 1
fi

kubectl exec --stdin --tty $POD_NAME -n $NAMESPACE -- /bin/bash



