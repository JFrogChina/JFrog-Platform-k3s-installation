
# kfs = k3s + frog

## Problems
1. More and more components are increasingly complex to install separately, while k3s + platform is simple
2. k3s + platform installation requires many docker images, and the customer environment may be air gap
3. Air gap is not only troublesome to install, but also troublesome to activate offline and configure demo

## Goals
1. It allows you to easily simulate an airgap installation in your own environment to ensure that everything goes well with a specific chart version
2. Installation can be as simple as copying a single file into the airgap environment
3. Even all the demo configurations made in your simulation environment can be preserved

## Guide

1. Enter the Simulated installation environment (non-airgap)

        In the non-airgap environment, execute the scripts in order, which will download all the installation packages required by the airgap environment.

        1. check & update Version
        vi ./common.sh

        2. execute the scripts in order
        ./1-download.sh
        ./2-install-k3s.sh
        ./3-install-jfrog.sh
        ./4-check-and-listen.sh
        ./5-package.sh

                you can choose whether to include the k3s data directory. 
                - If you do not include it, the package will be about 3GB.
                - If you include it, the package will be about 12GB. (To preserve your configuration)

<img src="./guide/5.png" style="width: 800px;" > 

2. Enter the Target installation environment (airgap) 

        Copy package to the airgap environment and execute the scripts in order again to install it. 
        
        ./1-download.sh

<img src="./guide/1.png" style="width: 800px;" > 

        ./2-install-k3s.sh

<img src="./guide/2.png" style="width: 800px;" > 

        ./3-install-jfrog.sh

                If you execute this script again, it will try to pull a new docker image to perform pre-upgrade checks.
                So if you need to upgrade, please make sure you have simulated the upgrade in the simulation environment and exported this docker image.

<img src="./guide/3.png" style="width: 800px;" > 

        ./4-check-and-listen.sh

<img src="./guide/4.png" style="width: 800px;" > 

## Verified Supported Systems

1. jfrog supported system = e.g. RHEL 8.x, 9.x
https://jfrog.com/help/r/jfrog-installation-setup-documentation/requirements-matrix

2. jfrog tested k3s = K3s v1.25.14+k3s1 (here tested v1.24)
https://jfrog.com/help/r/jfrog-installation-setup-documentation/k3s-installer-system-requirements

3. k3s v1.24 supported system version = e.g. RHEL 8.5 ~ 8.8
https://www.suse.com/suse-k3s/support-matrix/all-supported-versions/k3s-v1-24/

    
        | Simulated installation environment (non-airgap) | Target installation environment (airgap) | Support |
        |-------------------------------------------------|------------------------------------------|---------|
        | CentOS 7.9, 4C8GB, 40GB                         | CentOS 7.9, 4C8GB, 40GB                  | Y       |
        | CentOS 7.9, 4C8GB, 40GB                         | Redhat 8.8, 4C8GB, 40GB                  | Y       |
        | CentOS 7.9, 4C8GB, 40GB                         | Ubuntu 22.04, 4C8GB, 40GB                | Y       |
        https://www.tablesgenerator.com/markdown_tables

        

