require 'serverspec'

set :backend, :exec

describe "NodeJS" do
  describe command('which node') do
    its(:exit_status) { should eq 0 }
  end
end
