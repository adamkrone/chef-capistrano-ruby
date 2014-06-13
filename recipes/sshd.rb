execute "enable_agent_forwarding" do
  command "echo 'AllowAgentForwarding yes' >> /etc/ssh/sshd_config"
  not_if 'cat /etc/ssh/sshd_config | grep AllowAgentForwarding'
end
