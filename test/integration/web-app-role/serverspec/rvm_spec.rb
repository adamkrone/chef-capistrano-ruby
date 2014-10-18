require 'serverspec'

set :backend, :exec

describe "RVM" do
  describe file('/home/deploy/.rvm') do
    it { should be_directory }
  end

  describe file('/home/deploy/.rvm/wrappers/default/ruby') do
    it { should be_file }
    it { should be_executable }
  end

  describe command('/home/deploy/.rvm/wrappers/default/ruby -v') do
    its(:stdout) { should match /ruby 2.1.2/ }
  end
end
