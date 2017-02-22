#
# Cookbook:: capistrano-ruby
# Resource:: capistrano_ruby_app
#
# Copyright 2014 Adam Krone <adam.krone@thirdwavellc.com>
# Copyright 2014 Thirdwave, LLC
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

require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class CapistranoRubyApp < Chef::Resource::LWRPBase
      self.resource_name = :capistrano_ruby_app
      actions :create, :delete
      default_action :create

      attribute :app_name, kind_of: String, name_attribute: true
      attribute :cookbook, kind_of: String, default: 'capistrano-ruby'
      attribute :template, kind_of: String, default: 'app.conf.erb'
      attribute :deploy_root, kind_of: String, default: '/var/www'
      attribute :web_root, kind_of: String, default: 'public'
      attribute :deployment_user, kind_of: String, default: 'deploy'
      attribute :deployment_group, kind_of: String, default: 'deploy'
      attribute :server_name, kind_of: String, required: true
      attribute :server_aliases, kind_of: Array, default: nil
      attribute :ruby_version, kind_of: String, required: true
      attribute :ruby_gemset, kind_of: String, required: true
      attribute :environment, kind_of: String, default: 'production'
    end
  end
end
