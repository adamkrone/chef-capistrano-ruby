web_app node['capistrano-ruby']['app_name'] do
  template "app.conf.erb"
  server_name node['hostname']
  server_aliases [node['fqdn']]
  docroot "/var/www/current/public"
end
