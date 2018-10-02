#
# Cookbook:: capistrano-ruby
# Provider:: capistrano_ruby_app
#
# Copyright 2015 Adam Krone <adam.krone@thirdwavellc.com>
# Copyright 2015 Thirdwave, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class CapistranoRubyApp < Chef::Provider::LWRPBase
      include Chef::DSL::IncludeRecipe
      use_inline_resources if defined?(use_inline_resources)
      provides :capistrano_ruby_app

      def whyrun_supported?
        true
      end

      action :create do
        node.normal['apache']['docroot_dir'] = new_resource.deploy_root
        node.normal['apache']['user'] = new_resource.deployment_user
        node.normal['apache']['group'] = new_resource.deployment_group

        include_recipe 'apache2::default'

        apt_repository 'libapache2-mod-passenger' do
          uri 'https://oss-binaries.phusionpassenger.com/apt/passenger'
          components ['main']
          distribution node['lsb']['codename']
          key '561F9B9CAC40B2F7'
          keyserver 'keyserver.ubuntu.com'
          action :add
        end

        package 'libapache2-mod-passenger'

        node.normal['capistrano_ruby']['deployment_user'] = new_resource.deployment_user
        node.normal['capistrano_ruby']['environment'] = new_resource.environment
        node.normal['capistrano_ruby']['ruby_version'] = new_resource.ruby_version
        node.normal['capistrano_ruby']['ruby_gemset'] = new_resource.ruby_gemset

        capistrano_app new_resource.name do
          cookbook new_resource.cookbook
          template new_resource.template
          deploy_root new_resource.deploy_root
          web_root new_resource.web_root if new_resource.web_root
          deployment_user new_resource.deployment_user
          deployment_group new_resource.deployment_group
          server_name new_resource.server_name
          server_aliases new_resource.server_aliases if new_resource.server_aliases
        end

        apt_repository 'rvm' do
          uri 'ppa:rael-gc/rvm'
          distribution node['lsb']['codename']
          action :add
        end

        package 'rvm'

        execute 'add deploy to rvm' do
          command 'adduser deploy rvm'
          action :run
        end

        execute 'install ruby' do
          command "bash --login -c 'rvm install #{new_resource.ruby_version}'"
          action :run
          not_if { ::File.exist?("/usr/share/rvm/rubies/#{new_resource.ruby_version}") }
        end

        execute 'setup gemset' do
          command "bash --login -c 'rvm use #{new_resource.ruby_version} && rvm gemset create #{new_resource.ruby_gemset}'"
          action :run
          not_if { ::File.exist?("/usr/share/rvm/gems/#{new_resource.ruby_version}@#{new_resource.ruby_gemset}") }
        end

        execute 'setup bundler' do
          command "bash --login -c 'rvm use #{new_resource.ruby_version}@#{new_resource.ruby_gemset} && gem install bundler'"
          action :run
          not_if "ls /usr/share/rvm/gems/#{new_resource.ruby_version}@#{new_resource.ruby_gemset}/gems | grep bundler"
        end

        execute 'setup nodejs repo' do
          command "curl -sL https://deb.nodesource.com/setup_#{new_resource.node_version} | sudo -E bash -"
          action :run
          not_if { ::File.exist?('/etc/apt/sources.list.d/nodesource.list') }
        end

        package 'nodejs'

        service 'apache2' do
          action :restart
        end
      end

      action :delete do
        capistrano_app new_resource.name do
          deploy_root new_resource.deploy_root
          server_name new_resource.server_name
          action :delete
        end
      end
    end
  end
end
