capistrano_user 'deploy' do
  group_id 3000
  action :create
end

capistrano_ruby_app 'app' do
  environment 'qa'
  server_name 'app.dev'
  ruby_version 'ruby-2.4.0'
  ruby_gemset 'app'
end
