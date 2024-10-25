
- error

        # k3s airgap local-path storageclass not work, pvc pending, because ... kubectl get pods -n kube-system 

- fix by export (no need to fix by export)

        - only docker.io/xxx can be exported
        kubectl get pods -n kube-system -o jsonpath="{..image}"

        docker.io/rancher/local-path-provisioner:v0.0.23 
        rancher/local-path-provisioner:v0.0.23 
        rancher/mirrored-coredns-coredns:1.9.4 
        docker.io/rancher/mirrored-coredns-coredns:1.9.4 
        rancher/klipper-lb:v0.4.0 rancher/klipper-lb:v0.4.0 
        docker.io/rancher/klipper-lb:v0.4.0 
        docker.io/rancher/klipper-lb:v0.4.0 
        rancher/klipper-lb:v0.4.0 rancher/klipper-lb:v0.4.0 rancher/klipper-helm:v0.7.4-build20221121 
        docker.io/rancher/klipper-helm:v0.7.4-build20221121 
        rancher/klipper-helm:v0.7.4-build20221121 
        docker.io/rancher/klipper-helm:v0.7.4-build20221121 rancher/mirrored-metrics-server:v0.6.2 
        docker.io/rancher/mirrored-metrics-server:v0.6.2 
        rancher/mirrored-library-traefik:2.9.4 
        docker.io/rancher/mirrored-library-traefik:2.9.4

        - only filter docker.io/xxx
        kubectl get pods -n kube-system -o jsonpath="{..image}" | tr ' ' '\n' | grep "^docker.io"

        docker.io/rancher/local-path-provisioner:v0.0.23
        docker.io/rancher/mirrored-coredns-coredns:1.9.4
        docker.io/rancher/klipper-lb:v0.4.0
        docker.io/rancher/klipper-lb:v0.4.0
        docker.io/rancher/klipper-helm:v0.7.4-build20221121
        docker.io/rancher/klipper-helm:v0.7.4-build20221121
        docker.io/rancher/mirrored-metrics-server:v0.6.2
        docker.io/rancher/mirrored-library-traefik:2.9.4

        - export
        ...