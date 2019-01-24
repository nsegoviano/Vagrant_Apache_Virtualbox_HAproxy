# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "web1" do |web1|
    web1.vm.box = "ubuntu/trusty64"
    web1.vm.hostname = 'web1'
    web1.vm.box_url = "ubuntu/trusty64" 
    web1.vm.network :private_network, ip: "192.168.50.102"
    web1.vm.network :forwarded_port, host: 8081, guest: 80, auto_correct: true
    #config.vm.network :forwarded_port, host: 8081, guest: 80, auto_correct: true
    web1.vm.provision :shell, path: "bootstrap.sh"
    end
  config.vm.define "web2" do |web2|
    web2.vm.box = "ubuntu/trusty64"
    web2.vm.hostname = 'web2'
    web2.vm.box_url = "ubuntu/trusty64"
    web2.vm.network :private_network, ip: "192.168.50.103"
    web2.vm.network :forwarded_port, host: 8082, guest: 80, auto_correct: true
    #config.vm.network :forwarded_port, host: 8082, guest: 80, auto_correct: true
    web2.vm.provision :shell, path: "bootstrap.sh"
    end
  #Proxy server config
  config.vm.define "proxy1" do |proxy1|
    proxy1.vm.box = "ubuntu/trusty64"
    proxy1.vm.hostname = 'proxy1'
    proxy1.vm.box_url = "ubuntu/trusty64"
    proxy1.vm.network :private_network, ip: "192.168.50.101"
    proxy1.vm.network :forwarded_port, host: 8080, guest: 80, auto_correct: true
    #config.vm.network :forwarded_port, host: 8080, guest: 80, auto_correct: true
    proxy1.vm.provision :shell, path: "proxy_bootstrap.sh"
    end
end
