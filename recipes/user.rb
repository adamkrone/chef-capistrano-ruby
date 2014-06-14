include_recipe "users"

users_manage node['capistrano_ruby']['deployment_user'] do
  group_id 3000
  action :create
end

sudo node['capistrano_ruby']['deployment_user'] do
  user node['capistrano_ruby']['deployment_user']
  nopasswd true
end
