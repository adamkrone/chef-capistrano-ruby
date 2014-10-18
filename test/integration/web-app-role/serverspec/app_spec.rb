require 'serverspec'

set :backend, :exec

describe "App" do
  describe file('/etc/apache2/sites-available/app.conf') do
    it { should be_file }
  end

  describe file('/etc/apache2/sites-enabled/app.conf') do
    it { should be_file }
  end
end
