require 'serverspec'

set :backend, :exec

describe "Apache2" do
  describe package('apache2') do
    it { should be_installed }
  end
end
