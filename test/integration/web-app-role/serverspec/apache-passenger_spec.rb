require 'serverspec'

set :backend, :exec

describe "Apache Passenger" do
  describe package('libapache2-mod-passenger') do
    it { should be_installed }
  end
end
