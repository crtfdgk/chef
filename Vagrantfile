Vagrant.configure("2") do |config|
  config.vm.box = "10.10.3"
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_client do |chef|
    chef.provisioning_path = "/etc/chef"
    chef.chef_server_url = "https://api.chef.io/organizations/hubeng"
    chef.validation_key_path = ".chef/jzaval.pem"
    chef.validation_client_name = "jzaval"
    chef.node_name = "build-python"
  end

  config.ssh.username = 'admin'
  config.vm.synced_folder ".", "/vagrant", disabled: true
end
