# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "chef/ubuntu-12.04"

  config.omnibus.chef_version = :latest

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "172.16.30.10"

  config.vm.provision "chef_solo" do |chef|
    chef.data_bags_path = "data_bags"
    chef.add_recipe "chef-solo-search"
    chef.add_recipe "capistrano-ruby::default"
    chef.add_recipe "capistrano-ruby::postgres-client"
    chef.add_recipe "rvm::vagrant"

    chef.json = {
      :rvm => {
        :vagrant => {
          :system_chef_solo => "/opt/chef/bin/chef-solo"
        }
      }
    }
  end
end
