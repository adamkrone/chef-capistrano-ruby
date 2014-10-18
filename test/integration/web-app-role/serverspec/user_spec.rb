require 'serverspec'

set :backend, :exec

describe "User" do
  describe user('deploy') do
    it { should exist }
    it { should belong_to_group 'deploy' }
    it { should have_home_directory '/home/deploy' }
  end
end
