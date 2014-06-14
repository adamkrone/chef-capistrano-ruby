node.normal['postgresql'] = {
  :config => {
    :listen_addresses => "*"
  },
  :pg_hba => [
    {
      :addr => "0.0.0.0/0",
      :db => "all",
      :method => "md5",
      :type => "host",
      :user => "all"
    },
    {
      :addr => "::1/0",
      :db => "all",
      :method => "md5",
      :type => "host",
      :user => "all"
    }
  ],
  :password => {
    :postgres => "postgres"
  }
}

include_recipe 'postgresql::server'
