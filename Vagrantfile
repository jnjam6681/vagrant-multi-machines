# -*- mode: ruby -*-
# vi: set ft=ruby :

IP_NW = "192.168.33."

MASTER_NUM = 1
WORKER_NUM = 1

LB_IP = 30
MASTER_IP = 10
WORKER_IP = 20

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  # config.vm.box_check_update = false

  # master node
  (1..MASTER_NUM).each do |i|
    config.vm.define "master-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "kubernetes-master-#{i}"
        vb.memory = 2048
        vb.cpus = 2
      end
      node.vm.hostname = "master-#{i}"
      node.vm.network "private_network", ip: IP_NW + "#{MASTER_IP + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2510 + i}"

      node.vm.provision "setup-hosts", type: "shell", path: "./script/setup-hosts.sh"
      node.vm.provision "update-dns", type: "shell", path: "./script/update-dns.sh"
      node.vm.provision "install-docker", type: "shell", path: "./script/install-docker.sh"
    end
  end

  # load balancer node
  config.vm.define "loadbalancer" do |node|
    node.vm.provider "virtualbox" do |vb|
      vb.name = "kubernetes-ha-lb"
      vb.memory = 512
      vb.cpus = 1
    end
    node.vm.hostname = "loadbalancer"
    node.vm.network "private_network", ip: IP_NW + "#{LB_IP}"
    node.vm.network "forwarded_port", guest: 22, host: "2530"

    node.vm.provision "setup-hosts", type: "shell", path: "./script/setup-hosts.sh"
    node.vm.provision "update-dns", type: "shell", path: "./script/update-dns.sh"
  end

  # woker node
  (1..WORKER_NUM).each do |i|
    config.vm.define "worker-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "kubernetes-worker-#{i}"
        vb.memory = 512
        vb.cpus = 1
      end
      node.vm.hostname = "worker-#{i}"
      node.vm.network "private_network", ip: IP_NW + "#{WORKER_IP + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2520 + i}"

      node.vm.provision "setup-hosts", type: "shell", path: "./script/setup-hosts.sh"
      node.vm.provision "update-dns", type: "shell", path: "./script/update-dns.sh"
      node.vm.provision "install-docker", type: "shell", path: "./script/install-docker.sh"
    end
  end
end
