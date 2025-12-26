
# include common
source common.sh

helm list -n $NAMESPACE

# e.g.
# NAME          	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART                	APP VERSION
# jfrog-platform	jp       	5       	2025-07-17 10:57:24.893335 +0800 CST	deployed	jfrog-platform-11.0.0	7.104.5

# https://charts.jfrog.io/

echo
echo "get values of jfrog-platform"
helm get values jfrog-platform -n $NAMESPACE

echo
echo "get values of artifactory"
helm get values artifactory -n $NAMESPACE

echo
echo "get values of xray"
helm get values xray -n $NAMESPACE

