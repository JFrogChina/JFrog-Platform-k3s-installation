
# include common
source common.sh

POD_PREFIX=jfrog-platform-catalog

# 获取最新 pod 名称
POD_NAME=$(kubectl get pods -n $NAMESPACE \
  | grep "^$POD_PREFIX" \
  | awk '{print $1}' \
  | head -n 1)

if [ -z "$POD_NAME" ]; then
  echo "未找到 Pod: $POD_PREFIX"
  exit 1
fi

echo "正在查看 Pod 日志: $POD_NAME"
kubectl logs -f pod/$POD_NAME -n $NAMESPACE
