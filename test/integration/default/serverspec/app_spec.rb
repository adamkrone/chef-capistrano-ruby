require 'serverspec'

set :backend, :exec

describe "My App" do
  describe file('/etc/apache2/sites-available/my-app.conf') do
    it { should be_file }
    it { should contain 'PassengerRuby /home/deploy/.rvm/wrappers/default/ruby' }
    it { should contain 'RailsEnv production' }
  end

  describe file('/etc/apache2/sites-enabled/my-app.conf') do
    it { should be_file }
  end
end
