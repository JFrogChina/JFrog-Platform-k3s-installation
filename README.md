
# JFrog-Platform-k3s-installation

## Problems
- Installing individual components like Artifactory, Xray, and JAS can be complex. Using k3s with the JFrog Platform simplifies the process.
- The k3s and JFrog Platform installation requires multiple Docker images, which can complicate air-gapped (offline) installations.
- Air-gapped setups are challenging not only for installation but also for offline activation and demo configuration.

## Objectives
- Simulate an air-gapped installation in a non-air-gapped environment to ensure compatibility with a specific Helm chart version.
- Enable simplified installation in an air-gapped environment by copying a single package.
- Retain all demo configurations from the simulated environment in the final air-gapped setup.

## Guide

1. Non-airgap installation

- Check & Update JFrog Platform Helm Chart Version, for example: JFROG_CHART_VERSION=10.19.6. Get the latest version number from https://charts.jfrog.io/
```
vi ./common.sh
```

- Run the download script:

```
./1-download.sh
```
This downloads the required packages for k3s installation in the airgap environment and fetches Helm along with JFrog Platform’s Helm chart.

- Install k3s and JFrog Platform:

```
./2-install-k3s.sh
./3-install-jfrog.sh
```

- Check the Startup Status:
```
./4-check-and-listen.sh
```
- Check the pods to monitor the startup status. It may take a few minutes until all pods reach the "Running" state.
```
kubectl get po -A -w
```

- Access JFrog platform
Access the platform by http://vm_ip:8080  

2. Air-gapped installation
- Go through all steps in the non air-gapped installation.
- Package the installation packages:

```
./5-package.sh
```
This step is crucial:
You’ll be prompted to export the necessary JFrog Docker images (~2.9GB) for airgap installation.
Optionally, include the k3s_data_dir (~11GB) in the package, which preserves all demo configurations from the simulation environment for use in the airgap environment.

<img src="./guide/1.png" style="width: 800px;" > 

- Copy the single package to the airgap environment, unpack it, and execute the scripts in sequence again to install it.
        
        ./1-download.sh

<img src="./guide/2.png" style="width: 800px;" > 

        ./2-install-k3s.sh

<img src="./guide/3.png" style="width: 800px;" > 

        ./3-install-jfrog.sh

- If you have included k3s_data_dir in your package, you don't need to perform this step.

- If you execute this script again, it will try to pull 1 more new docker image to perform pre-upgrade checks.
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

    
        | Simulated installation environment (non-airgap) | Target installation environment (airgap) | Support |
        |-------------------------------------------------|------------------------------------------|---------|
        | CentOS 7.9, 4C8GB, 40GB                         | CentOS 7.9, 4C8GB, 40GB                  | Y       |
        | CentOS 7.9, 4C8GB, 40GB                         | Redhat 8.8, 4C8GB, 40GB                  | Y       |
        | CentOS 7.9, 4C8GB, 40GB                         | Ubuntu 22.04, 4C8GB, 40GB                | Y       |
        https://www.tablesgenerator.com/markdown_tables

        

