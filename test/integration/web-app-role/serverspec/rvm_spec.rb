require 'serverspec'

set :backend, :exec

describe "RVM" do
  describe file('/usr/share/rvm') do
    it { should be_directory }
  end
end
