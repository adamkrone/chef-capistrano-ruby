default['capistrano_ruby']['app_name'] = 'app'
default['capistrano_ruby']['environment'] = 'production'
default['capistrano_ruby']['deployment_user'] = 'deploy'
default['capistrano_ruby']['deployment_group'] = 'www-data'

default['capistrano_ruby']['db']['user'] = 'deploy'
default['capistrano_ruby']['db']['user_password'] = 'deploy'
default['capistrano_ruby']['db']['environments'] = ['app_development', 'app_staging', 'app_production']
