require 'serverspec'

set :backend, :exec

describe "PostgreSQL" do
  describe package('postgresql-9.1'), :if => os[:release] == '12.04' do
    it { should be_installed }
  end

  describe package('postgresql-9.3'), :if => os[:release] == '14.04' do
    it { should be_installed }
  end
end
