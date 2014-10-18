require 'serverspec'

set :backend, :exec

describe "SSH" do
  describe file('/etc/ssh/sshd_config') do
    it { should contain 'AllowAgentForwarding yes' }
  end
end
