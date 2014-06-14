web_app node['capistrano_ruby']['app_name'] do
  template "app.conf.erb"
  docroot "/var/www/current/public"
end
