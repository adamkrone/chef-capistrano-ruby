#
# Cookbook Name:: apache-passenger
# Recipe:: default
#
# Copyright (C) 2014 
#
#
#

include_recipe 'apt::default'
include_recipe 'capistrano-ruby::user'
include_recipe 'capistrano-ruby::rvm'
include_recipe 'nodejs::default'
include_recipe 'apache2::default'
include_recipe 'capistrano-ruby::apache-passenger'
include_recipe 'capistrano-ruby::chown'
include_recipe 'capistrano-ruby::app'
include_recipe 'capistrano-ruby::sshd'
