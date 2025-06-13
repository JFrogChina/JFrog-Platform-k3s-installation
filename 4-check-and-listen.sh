
# include common
source common.sh

echo
echo "check start"
echo "****************************************************"

echo
echo "1. check install status, please wait ..."
echo "----------------------------------------------------"
kubectl get pods -n $NAMESPACE


echo
echo "2. check storage status"
echo "----------------------------------------------------"
du -sh $K3S_DATA_DIR
# e.g. 11 GB

echo
echo "3. try to listen"
echo "----------------------------------------------------"

# about port
# if 8080:80, web page works, but docker login ip:8080 fails because repo does not have port in path
# if 80:80, kubectl port-forward --address 80:80 not work, no reason but 80 fails!

# so 
# 1. vi downlaod/jfrog/jfrog-platform-custom-values.yaml > externalPort: 8080
# 2. use 8080:8080 as below

# kill kubectl to stop
kubectl port-forward -n $NAMESPACE svc/jfrog-platform-artifactory-nginx 8080:8080 --address 0.0.0.0 &
kubectl port-forward -n $NAMESPACE svc/jfrog-platform-artifactory-nginx 8443:8443 --address 0.0.0.0 &

kubectl port-forward -n $NAMESPACE svc/artifactory-artifactory-nginx 38080:38080 --address 0.0.0.0 &

echo "*************************************************************************"
echo "*  if listen success with jfrog-platform, visit http://public-ip:8080   *"
echo "*  if listen success with jfrog-platform, visit https://public-ip:8443  *"
echo "*  if listen success with artifactory, visit http://public-ip:38080     *"
echo "*************************************************************************"






