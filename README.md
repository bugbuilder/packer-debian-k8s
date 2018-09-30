# packer-debian-k8s
Original from [chef/bento](https://github.com/chef/bento)

This packer repository create a debian [image](https://app.vagrantup.com/bugbuilder/boxes/debian-9.5-k8s/versions/1.12) that have the necessary binaries
to run k8s.

# Box usage

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
