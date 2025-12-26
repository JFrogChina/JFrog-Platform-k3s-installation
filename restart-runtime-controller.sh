# include common
source common.sh

# controller
kubectl delete pod -n $NAMESPACE -l app.kubernetes.io/name=runtime-sensors

# sensors
kubectl delete pod -n $NAMESPACE -l name=jfs-runtime-sensor




