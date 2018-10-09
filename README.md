# packer-debian-k8s
Original from [chef/bento](https://github.com/chef/bento)

This packer repository create a debian [image](https://app.vagrantup.com/bugbuilder/boxes/debian-9.5-k8s/versions/1.12) that have the necessary binaries
to run k8s.

# box usage

```
Vagrant.configure("2") do |config|
  config.vm.box = "bugbuilder/debian-9.5-k8s"
  config.vm.box_version = "1.12"
end
```

```
vagrant init bugbuilder/debian-9.5-k8s \
  --box-version 1.12
vagrant up
```
# Vagrantfile example

```
GUI     = false

M_RAM   = 1024
M_CPU   = 2

W_RAM   = 1024
W_CPU   = 2

DOMAIN  = ".bennu.cl"
NETWORK = "192.168.99."
NETMASK = "255.255.255.0"

BOX     = "bugbuilder/debian-9.5-k8s"
VERSION = "1.12"

Vagrant.configure(2) do |config|

    config.vm.define "manager" do |manager|
      manager.vm.box = BOX
      manager.vm.box_version = VERSION

      manager.vm.guest = :debian
      manager.vm.hostname = "manager" + DOMAIN
      manager.vm.network 'private_network', ip: "192.168.99.20", netmask: NETMASK, virtualbox__intnet: true

      manager.vm.provider "virtualbox" do |vbox|
        vbox.gui = GUI
        vbox.memory = M_RAM
        vbox.cpus = M_CPU
      end
    end

   config.vm.define "worker1" do |worker1|
      worker1.vm.box = BOX
      worker1.vm.box_version = VERSION

      worker1.vm.guest = :debian
      worker1.vm.hostname = "worker1" + DOMAIN
      worker1.vm.network 'private_network', ip: "192.168.99.21", netmask: NETMASK, virtualbox__intnet: true

      worker1.vm.provider "virtualbox" do |vbox|
        vbox.gui = GUI
        vbox.memory = W_RAM
        vbox.cpus = W_CPU
      end
    end

    config.vm.define "worker2" do |worker2|
      worker2.vm.box = BOX
      worker2.vm.box_version = VERSION

      worker2.vm.guest = :debian
      worker2.vm.hostname = "worker2" + DOMAIN
      worker2.vm.network 'private_network', ip: "192.168.99.22", netmask: NETMASK, virtualbox__intnet: true

      worker2.vm.provider "virtualbox" do |vbox|
        vbox.gui = GUI
        vbox.memory = W_RAM
        vbox.cpus = W_CPU
      end
    end
end
```
