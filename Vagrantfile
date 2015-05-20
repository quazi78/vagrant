Vagrant::Config.run do |config|
  config.vm.define :master do |master_config|
    master_config.vm.box       = "centos64-x86_64-20140116"
    master_config.vm.host_name = "master.puppetlabs.vm"
    master_config.vm.network :hostonly, "192.168.33.10"
    master_config.vm.forward_port 80, 8084
    master_config.vm.provision :shell, :path => "master.sh"
    master_config.vm.share_folder "puppet_mount", "/puppet", "puppet"
  end

  config.vm.define :agent do |agent_config|
    agent_config.vm.box       = "centos64-x86_64-20140116"
    agent_config.vm.host_name = "agent.puppetlabs.vm"
    agent_config.vm.network :hostonly, "192.168.33.11"
    agent_config.vm.provision :shell, :path => "agent.sh"
  end
end
