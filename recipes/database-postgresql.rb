include_recipe 'database::postgresql'

postgresql_connection_info = {
  :host     => '127.0.0.1',
  :port     => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

postgresql_database_user node['capistrano_ruby']['db']['user'] do
  connection postgresql_connection_info
  password node['capistrano_ruby']['db']['user_password']
  action :create
end

node['capistrano_ruby']['db']['environments'].each do |env|
  database_name = "#{node['capistrano_ruby']['db']['name']}_#{env}"

  postgresql_database database_name do
    connection postgresql_connection_info
    action :create
  end

  postgresql_database_user node['capistrano_ruby']['db']['user'] do
    connection postgresql_connection_info
    database_name database_name
    privileges [:all]
    action :grant
  end
end
