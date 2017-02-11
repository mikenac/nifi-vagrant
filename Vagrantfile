# -*- mode: ruby -*-
# vi: set ft=ruby :

#This is a Vagrantfile to build a box and checkout Apache Nifi

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.memory = 4096
    vb.cpus = 2
    vb.name = "nifi-example-build"
  end
   
   config.vm.provision "shell", path: "provision.sh"
end