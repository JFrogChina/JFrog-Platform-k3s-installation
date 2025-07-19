
# include common
source common.sh

helm list -n $NAMESPACE

# e.g.
# NAME          	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART                	APP VERSION
# jfrog-platform	jp       	5       	2025-07-17 10:57:24.893335 +0800 CST	deployed	jfrog-platform-11.0.0	7.104.5

# https://charts.jfrog.io/

