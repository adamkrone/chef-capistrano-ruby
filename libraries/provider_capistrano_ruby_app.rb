#
# Cookbook:: capistrano-ruby
# Provider:: capistrano_ruby_app
#
# Copyright 2014 Adam Krone <krone.adam@gmail.com>
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

      def whyrun_supported?
        true
      end

      action :create do
        node.normal['rvm']['user_installs'] = [
          { 'user' => new_resource.deployment_user,
            'default_ruby' => new_resource.ruby_version }
        ]

        include_recipe 'rvm::user'

        node.normal['apache']['docroot_dir'] = new_resource.deploy_root
        node.normal['apache']['user'] = new_resource.deployment_user
        node.normal['apache']['group'] = new_resource.deployment_group
        node.normal['apache']['mpm'] = 'event'

        include_recipe 'apache2::default'

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

        template "#{node['apache']['dir']}/sites-available/#{new_resource.name}.conf" do
          source new_resource.template
          owner 'root'
          group node['apache']['root_group']
          mode '0644'
          cookbook new_resource.cookbook
          variables(
            application_name: new_resource.name,
            deployment_user: new_resource.deployment_user,
            docroot: new_resource.docroot,
            environment: new_resource.environment,
            server_name: new_resource.server_name,
            server_aliases: new_resource.server_aliases
          )
          if ::File.exist?("#{node['apache']['dir']}/sites-enabled/#{new_resource.name}.conf")
            notifies :reload, 'service[apache2]', :delayed
          end
        end

        apt_repository 'libapache2-mod-passenger' do
          uri          'https://oss-binaries.phusionpassenger.com/apt/passenger'
          distribution node['lsb']['codename']
          components   ['main']
          keyserver    'keyserver.ubuntu.com'
          key          '561F9B9CAC40B2F7'
        end

        package 'libapache2-mod-passenger'

        include_recipe 'nodejs::default'
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
