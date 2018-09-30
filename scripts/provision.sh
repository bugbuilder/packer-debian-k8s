#!/bin/sh
apt-get update
apt-get install -y \
 apt-transport-https \
 ca-certificates \
 curl \
 bridge-utils \
 ipvsadm \
 gnupg2 \
 tmux

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
echo "deb https://download.docker.com/linux/debian stretch stable" | tee /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y \
 docker-ce

usermod -aG docker vagrant
systemctl enable docker

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y \
 kubelet \
 kubeadm \
 kubectl

apt-mark hold \
 kubelet
 kubeadm
 kubectl

sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
kubeadm config images pull

# load modules for current session

modprobe br_netfilter \
    ip_vs \
    ip_vs_rr \
    ip_vs_wrr \
    ip_vs_sh \
    nf_conntrack_ipv4

# modules persistence on every boot

cat <<EOF >/etc/modules
br_netfilter
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack_ipv4
EOF

# ensure iptables rules

cat <<EOF >/etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

cat <<EOF >> ${HOME}/.tmux.conf
set -g default-terminal "screen-256color"
set -g prefix C-z
unbind C-b
bind C-z last-window
bind z send-prefix

setw -g mode-keys vi
unbind-key j
bind-key j select-pane -D
unbind-key k
bind-key k select-pane -U
unbind-key h
bind-key h select-pane -L
unbind-key l
bind-key l select-pane -R
EOF

