# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty32"
  config.vm.network "private_network", ip: "77.77.77.7"
  config.vm.provision "shell", path: "config/initializers/provision_ubuntu.sh"
end
