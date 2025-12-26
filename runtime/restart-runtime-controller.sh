# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
source $APP_DIR/../common.sh

# controller
kubectl delete pod -n $NAMESPACE -l app.kubernetes.io/name=runtime-sensors

# sensors
kubectl delete pod -n $NAMESPACE -l name=jfs-runtime-sensor




