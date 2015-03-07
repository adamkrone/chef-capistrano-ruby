#
# Cookbook Name:: capistrano-ruby-test
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

capistrano_user 'deploy' do
  group_id 3000
end

capistrano_ruby_app 'my-app' do
  environment 'production'
  server_name 'my-app.com'
  ruby_version 'ruby-2.2.0'
end
