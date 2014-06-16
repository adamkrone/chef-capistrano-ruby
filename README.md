# Capistrano Ruby Cookbook

Configures systems to run Ruby applications that will be deployed using Capistrano.
Currently, it's designed for a very specific environment:

* Apache Passenger
* RVM
* Postgresql

It uses a users data bag to setup the deployment user.

## Important Attributes

While most aspects are hard coded, here are the important attributes you'll need to provide:

```ruby
{
  :capistrano_ruby => {
    :app_name => 'my_rails_app',                    # Name of the app
    :environment => 'staging'                       # Environment Apache Passenger runs in
    :deployment_user => 'deploy'                    # User account created for deployment
    :deployment_group => 'deploy'                   # User group created for deployment
    :db => {
        :user => 'my_user',                         # Database user
        :user_password => 'myuserpassword',         # Database user's password
        :name => 'my_rails_app',                    # Name of your app
        :environments => ['staging', 'production']  # Environment databases that should be created
    }
  }
}
```

The db environments get appended to the db name with an underscore. Using the above example,
it will generate the following databases:

* my_rails_app_staging
* my_rails_app_production
