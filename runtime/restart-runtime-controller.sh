# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/../common.sh

# controller
kubectl delete pod -n $NAMESPACE -l app.kubernetes.io/name=runtime-sensors

# sensors
kubectl delete pod -n $NAMESPACE -l name=jfs-runtime-sensor




