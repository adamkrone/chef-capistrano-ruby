include_recipe "users"

users_manage "deploy" do
  group_id 3000
  action :create
end

sudo "deploy" do
  user "deploy"
  nopasswd true
end
