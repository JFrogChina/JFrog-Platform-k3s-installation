
# JFrog-Platform-k3s-installation / kfs

kfs = k3s + jfrog platform

## Problems
1. More and more components(e.g. Artifactory, Xray, JAS) are increasingly complex to install separately, while k3s + jfrog platform is simple
2. k3s + jfrog platform installation requires many docker images, and the customer environment may be airgap
3. Airgap is not only troublesome to install, but also troublesome to activate offline and configure demo

## Goals
1. It allows you to easily simulate an airgap installation in your own environment to ensure that everything goes well with a specific chart version
2. Installation can be as simple as copying a single file into the airgap environment
3. Even all the demo configurations made in your simulated installation environment can be preserved

## Guide

1. Enter the simulated installation environment (non-airgap)

        Please note:
        k3s comes with its own Containerd, if you have Docker & Containerd install, uninstall them

                ./uninstall-docker.sh

        First, check & update version of jfrog platofm's helm chart
        
                check all releases here - https://jfrog.com/download-legacy/?product=platform&version=7.98.7
                1. Product - Select Platform
                2. Version - Select 7.98.7 (this is Artifactory Version)
                3. click Helm icon - you see chart version is 10.20.0

                        vi ./common.sh
                        e.g. JFROG_CHART_VERSION=10.20.0
                        for the chart's source code, check https://charts.jfrog.io/

        Then, execute the scripts in order.
        ./1-download.sh

                This step will download the packages required to install k3s in the airgap environment.
                It will also download helm and jfrog platform's helm chart.

        ./2-install-k3s.sh
        ./3-install-jfrog.sh

                This is how we can accurately parse the required jfrog docker images.

        ./4-check-and-listen.sh

                You can execute this script repeatedly to see its startup status. It usually takes several minutes until all pods become running.

        ./5-package.sh

                This step is very important. 
                First, you will choose to export jfrog docker images(about 2.9GB) for subsequent installation in the airgap environment.

                Then, it will ask you whether to include k3s_data_dir(about 11GB) in the package.
                The benefit of including it is that all the demo configurations you make in the simulation environment will be retained in the airgap environment.

<img src="./guide/1.png" style="width: 800px;" > 

2. Enter the target installation environment (airgap) 

        Please note:
        k3s comes with its own Containerd, if you have Docker & Containerd install, uninstall them

                ./uninstall-docker.sh
                
        Copy the single package to the airgap environment, unpack it, and execute the scripts in sequence again to install it.
        
        ./1-download.sh

<img src="./guide/2.png" style="width: 800px;" > 

        ./2-install-k3s.sh

<img src="./guide/3.png" style="width: 800px;" > 

        ./3-install-jfrog.sh

                If you have included k3s_data_dir in your package, you don't need to perform this step.

                If you execute this script again, it will try to pull 1 more new docker image to perform pre-upgrade checks.
                So if you need to upgrade, please make sure you have simulated the upgrade in the simulation environment and exported this docker image.

<img src="./guide/4.png" style="width: 800px;" > 

        ./4-check-and-listen.sh

<img src="./guide/5.png" style="width: 800px;" > 

## Verified Supported Systems

1. jfrog supported system = e.g. RHEL 8.x, 9.x
https://jfrog.com/help/r/jfrog-installation-setup-documentation/requirements-matrix

2. jfrog tested k3s = K3s v1.25.14+k3s1 (here tested v1.24)
https://jfrog.com/help/r/jfrog-installation-setup-documentation/k3s-installer-system-requirements

3. k3s v1.24 supported system version = e.g. RHEL 8.5 ~ 8.8
https://www.suse.com/suse-k3s/support-matrix/all-supported-versions/k3s-v1-24/

        Please note:
        If you want to load the xray vulnerability library, higher system configuration is required
        e.g. 8C16GB, 300GB
    
        | Simulated installation environment (non-airgap) | Target installation environment (airgap) | Support |
        |-------------------------------------------------|------------------------------------------|---------|
        | CentOS 7.9, 4C8GB, 40GB                         | CentOS 7.9, 4C8GB, 40GB                  | Y       |
        | CentOS 7.9, 4C8GB, 40GB                         | Redhat 8.8, 4C8GB, 40GB                  | Y       |
        | CentOS 7.9, 4C8GB, 40GB                         | Ubuntu 22.04, 4C8GB, 40GB                | Y       |
        https://www.tablesgenerator.com/markdown_tables

        

