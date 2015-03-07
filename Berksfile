source "https://api.berkshelf.com"

metadata

cookbook 'apt'
cookbook 'chef-solo-search', github: 'edelight/chef-solo-search'
cookbook 'capistrano-base', github: 'thirdwavellc/chef-capistrano-base'
cookbook 'ssh-hardening', github: 'TelekomLabs/chef-ssh-hardening', tag: 'v1.0.2'
cookbook 'rvm', github: 'fnichol/chef-rvm', tag: 'v0.9.2'
cookbook 'nodejs'

group :test do
  cookbook 'capistrano-base-test', github: 'thirdwavellc/chef-capistrano-base', rel: 'spec/fixtures/cookbooks/capistrano-base-test'
  cookbook 'capistrano-ruby-test', path: 'spec/fixtures/cookbooks/capistrano-ruby-test'
end
