# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'chef/ubuntu-14.04'

  config.omnibus.chef_version = :latest

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  config.vm.define 'app' do |app|
    app.vm.network 'private_network', ip: '172.16.30.11'

    app.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'

      chef.add_recipe 'chef-solo-search'
      chef.add_recipe 'capistrano-ruby::web-app-role'
      chef.add_recipe 'rvm::vagrant'

      chef.json = {
        :rvm => {
          :vagrant => {
            :system_chef_solo => '/opt/chef/bin/chef-solo'
          }
        }
      }
    end
  end

  config.vm.define 'db' do |db|
    db.vm.network 'private_network', ip: '172.16.30.20'

    db.vm.provision 'chef_solo' do |chef|
      chef.data_bags_path = 'data_bags'

      chef.add_recipe 'chef-solo-search'
      chef.add_recipe 'capistrano-ruby::postgresql-role'
      chef.add_recipe 'rvm::vagrant'

      chef.json = {
        :rvm => {
          :vagrant => {
            :system_chef_solo => '/opt/chef/bin/chef-solo'
          }
        },
        :capistrano_ruby => {
          :db => {
            :user => 'simple_rails_app',
            :user_password => 'simplerailsapp',
            :name => 'simple_rails_app',
            :environments => ['development', 'staging', 'production']
          }
        }
      }
    end
  end
end
