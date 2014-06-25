node.normal['rvm']['user_installs'] = [
  { 'user' => node['capistrano_ruby']['deployment_user'],
    'default_ruby' => node['capistrano_ruby']['ruby_version']}
]

include_recipe 'rvm::user'
