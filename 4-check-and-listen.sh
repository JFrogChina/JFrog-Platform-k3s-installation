
# include common
source common.sh

echo
echo "check start"
echo "****************************************************"

echo
echo "1. check install status, please wait ..."
echo "----------------------------------------------------"
kubectl get pods -n jp


echo
echo "2. check storage status"
echo "----------------------------------------------------"
du -sh $K3S_DATA_DIR
# e.g. 11 GB

echo
echo "3. try to listen on public-ip:8080"
echo "----------------------------------------------------"
# use 8080:80
# use --address 0.0.0.0
# kill kubectl to stop
kubectl port-forward --namespace jp svc/jfrog-platform-artifactory-nginx 8080:80 --address 0.0.0.0 &

echo "****************************************************"
echo "*  if listen success, visit http://public-ip:8080  *"
echo "****************************************************"






