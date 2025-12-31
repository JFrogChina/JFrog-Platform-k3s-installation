
# include common
SHELL_DIR=$(dirname "$BASH_SOURCE")
SHELL_PATH=$(cd $SHELL_DIR; pwd)
source $SHELL_PATH/common.sh

echo
echo "patch xray svc start"
echo "****************************************************"

kubectl patch svc xray \
--namespace $NAMESPACE \
  -p '{
    "spec": {
      "type": "NodePort",
      "ports": [
        {
          "name": "http",
          "port": 80,
          "targetPort": 8000,
          "protocol": "TCP"
        },
        {
          "name": "http-router",
          "port": 8082,
          "targetPort": 8082,
          "protocol": "TCP",
          "nodePort": 30080
        }
      ]
    }
  }'

echo
echo "patch xray svc end "
echo "****************************************************"
