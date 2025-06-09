
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

### 1. Enter the simulated installation environment (non-airgap)   

1.1 Uninstall Docker

        k3s comes with its own Containerd, if you have Docker & Containerd install, uninstall them

        ./uninstall-docker.sh

1.2 Check & update version of jfrog platofm's helm chart

        vi ./common.sh

        e.g. JFROG_CHART_VERSION=10.20.0

        check all releases here - https://jfrog.com/download-legacy/?product=platform&version=7.98.7

        1. Product - Select Platform
        2. Version - Select 7.98.7 (this is Artifactory Version)
        3. Click Helm icon - you see chart version is 10.20.0, to understand the chart's source code, check https://charts.jfrog.io/

1.3 Install

        ./1-download.sh

                This step will check if the packages have been downloaded, if not, download them (k3s, helm, jfrog platform's helm chart).

                And copy the downloaded package to the directory waiting to be installed

        ./2-install-k3s.sh

                If there are any errors, you can check the status with this command

                systemctl status k3s

        ./3-install-jfrog.sh

                This is how we can accurately parse the required jfrog docker images.

        ./4-check-and-listen.sh

                You can execute this script repeatedly to see its startup status. It usually takes several minutes until all pods become running.

        ./5-package.sh

                ⚠️ Important
                Before performing this step:

                You should execute ./3-install-jfrog.sh again to test the upgrade process, because during the upgrade it will try to pull a new Docker image to perform pre-upgrade checks. This will ensure that you do not lose this image later when you package the installation package and perform the upgrade in an isolated environment.

                ⚠️ Important
                When you perform this step:

                First, you will choose to export jfrog docker images(about 2.9GB) for subsequent installation in the airgap environment.

                Then, it will ask you whether to include k3s_data_dir(about 11GB) in the package.

                The benefit of including it is that all the demo configurations you make in the simulation environment will be retained in the airgap environment.

<img src="./guide/1.png" style="width: 800px;" > 

1.4 Offline Activation of JFrog Platform in an Air-gapped Environment

        https://jfrog.com/help/r/jfrog-installation-setup-documentation/configure-jfrog-platform-in-an-air-gapped-environment

        ⚠️ Important
        In this document, the first step is to change the Artifactory System YAML file.
        
        There are several ways to make changes:
        1. By configuring custom-values.yaml (tested NOT work 2025-06-04, JFROG_CHART_VERSION=10.20.0)

                vi ./kfs/download/jfrog/custom-values.yaml
                set extraSystemYaml in it
   
        2. By directly change the system.yaml file

                1. check & unzip the downloaded chart
                2. update ./kfs/download/jfrog-platform/charts/artifactory/files/system.yaml directly
                3. tar -czf jfrog-platform-10.20.0.tgz jfrog-platform

        After the configuration changes, restart Artifactory by deleting pod of Artifactory

1.5 Xray DB Sync
        
        https://jfrog.com/help/r/jfrog-security-user-guide/products/xray/xray-management/xray-and-jfrog-external-db-sync

        When clicking the Sync button, please observe the xray log first.
        ./check-xray-log.sh

### 2. Enter the target installation environment (airgap) 

2.1 Uninstall Docker

        k3s comes with its own Containerd, if you have Docker & Containerd install, uninstall them

        ./uninstall-docker.sh

2.2 Copy

        Copy the single package to the airgap environment, unpack it, and execute the scripts in sequence again to install it.

2.3 Install

        ./1-download.sh

                This step will copy the downloaded package to the directory waiting to be installed

<img src="./guide/2.png" style="width: 800px;" > 

        ./2-install-k3s.sh

<img src="./guide/3.png" style="width: 800px;" > 

        ./3-install-jfrog.sh

                If you have included k3s_data_dir in your package, you don't need to perform this step.

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

        | CentOS 7.9, 4C8G, 40GB                          | CentOS 7.9, 4C8G, 40GB                  | Y       |

        | CentOS 7.9, 4C8G, 40GB                          | Redhat 8.8, 4C8G, 40GB                  | Y       |

        | CentOS 7.9, 4C8G, 40GB                          | Ubuntu 22.04, 4C8G, 40GB                | Y       |

        https://www.tablesgenerator.com/markdown_tables

## Resource Requirements

        | Components to be tested               | Required Resources    |
        |---------------------------------------|-----------------------|
        | Artifactory                           | 4C8G                  |
        | Artifactory + Security (Xray/JAS/...) | 8C16G（Minimum）      |
        | Artifactory + Security (Xray/JAS/...) | 16C32G（Recommended） |

