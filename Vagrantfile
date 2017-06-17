# -*- mode: ruby -*-

# vi: set ft=ruby :
 
VAGRANTFILE_API_VERSION = "2"
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.ssh.insert_key = false
  config.vm.hostname = "puppetserver.hacklab"
  config.vm.box = "gutocarvalho/centos7x64"
  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.customize [ "modifyvm", :id, "--cpus", "2" ]
    virtualbox.customize [ "modifyvm", :id, "--memory", "3000" ]
    virtualbox.gui = true
  end
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
end
