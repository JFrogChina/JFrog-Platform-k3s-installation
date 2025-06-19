
# include common
source common.sh

echo
echo "check k3s status"
echo "----------------------------------------------------"

# systemctl cat k3s
systemctl status k3s

kubectl get ns
# e.g.
# NAME              STATUS   AGE
# default           Active   5m13s
# jp                Active   4m23s
# kube-node-lease   Active   5m13s
# kube-public       Active   5m13s
# kube-system       Active   5m13s







