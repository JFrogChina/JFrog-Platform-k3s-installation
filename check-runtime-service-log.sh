
# include common
source common.sh

POD_PREFIX=runtime

POD_NAME=$(kubectl get pods -n $NAMESPACE \
  | grep "^$POD_PREFIX" \
  | awk '{print $1}' \
  | head -n 1)

if [ -z "$POD_NAME" ]; then
  echo "cannot find Pod: $POD_PREFIX"
  exit 1
fi

echo "checking log of Pod: $POD_NAME"
kubectl logs -f pod/$POD_NAME -c router -n $NAMESPACE

