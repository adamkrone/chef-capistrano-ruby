require 'serverspec'

set :backend, :exec

describe "Chown" do
  describe file('/var/www') do
    it { should be_owned_by 'deploy' }
    it { should be_grouped_into 'www-data' }
  end
end
