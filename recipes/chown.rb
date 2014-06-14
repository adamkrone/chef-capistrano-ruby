directory node['apache']['docroot_dir'] do
  owner node['capistrano_ruby']['deployment_user']
  group node['capistrano_ruby']['deployment_group']
  recursive true
  action :create
end
