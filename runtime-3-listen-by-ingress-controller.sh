
# include common
source common.sh

echo
echo "listen start"
echo "****************************************************"

echo
echo "try to listen by ingress controller"
echo "----------------------------------------------------"

# 2. listren by ingress controller
kubectl port-forward -n $NAMESPACE svc/ingress-nginx-controller 8080:8080 --address 0.0.0.0 &
kubectl port-forward -n $NAMESPACE svc/ingress-nginx-controller 8443:8443 --address 0.0.0.0 &

echo "*************************************************************************"
echo "*  if listen success with ingress controller, visit http://public-ip:8080   *"
echo "*  if listen success with ingress controller, visit https://public-ip:8443  *"
echo "*************************************************************************"






