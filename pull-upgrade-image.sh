



# upgrade pre check image

# 1. check image
# e.g. kubectl describe pod/jfrog-platform-xxx-pre-xxx
# releases-docker.jfrog.io/bitnami/kubectl:1.31.2

# 2. pull in internet vm
ctr image pull releases-docker.jfrog.io/bitnami/kubectl:1.31.2
ctr image ls | grep kubectl

# 3. export
ctr image export kubectl_1.31.2.tar releases-docker.jfrog.io/bitnami/kubectl:1.31.2

# 4. import in airgap vm
# ctr image import /path/to/save/kubectl_1.31.2.tar


