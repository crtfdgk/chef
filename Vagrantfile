Vagrant.configure("2") do |config|
  config.vm.box = "10.10.5"
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_client do |chef|
    chef.provisioning_path = "/etc/chef"
    chef.chef_server_url = "https://api.chef.io/organizations/hubeng"
    chef.validation_key_path = ".chef/erichanko.pem"
    chef.validation_client_name = "erichanko"
    chef.node_name = "build-python_osx_10-10"
  end

  config.ssh.username = 'admin'
  config.vm.synced_folder ".", "/vagrant", disabled: true
end
