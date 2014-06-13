node.normal['rvm']['user_installs'] = [
  { 'user' => 'deploy',
    'default_ruby' => 'ruby-2.1.2'}
]

include_recipe 'rvm::user'
