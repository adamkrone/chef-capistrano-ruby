node.normal['rvm']['user_installs'] = [
  { 'user' => node['capistrano_ruby']['deployment_user'],
    'default_ruby' => 'ruby-2.1.2'}
]

include_recipe 'rvm::user'
