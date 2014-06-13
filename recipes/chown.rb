directory node['apache']['docroot_dir'] do
  owner 'deploy'
  group 'www-data'
  recursive true
  action :create
end
