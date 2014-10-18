require 'serverspec'

set :backend, :exec

describe "Database" do
  %w{development staging production}.each do |env|
    describe command("su postgres -c 'psql -l' | grep simple_rails_app_#{env}") do
      its(:exit_status) { should eq 0 }
    end
  end
end
