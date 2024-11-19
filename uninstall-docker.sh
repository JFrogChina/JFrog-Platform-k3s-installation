
# k3s comes with its containerd, it does not need docker
# if docker & its containerd are installed, k3s will use this containerd, so it will pull images from internet

rm -rf /etc/docker
rm -rf /etc/containerd

rm -rf /var/lib/docker
rm -rf /var/lib/containerd

rm -rf /usr/bin/containerd

rm -f /usr/local/bin/containerd
rm -f /usr/local/bin/ctr
rm -f /usr/local/bin/containerd-shim
rm -f /usr/local/bin/containerd-shim-runc-v1

rm -f /etc/systemd/system/containerd.service
rm -f /etc/systemd/system/containerd.socket

systemctl daemon-reload

ps aux | grep containerd
pkill containerd

systemctl status containerd


