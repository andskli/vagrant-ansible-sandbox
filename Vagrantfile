# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  {
    'admnode' => {
      :box => 'chef/centos-7.0',
    },
    'n1' => {
      :box => 'chef/centos-7.0',
    },
    'n2' => {
      :box => 'chef/centos-7.0',
    },
  }.each do |box, cfg|
      config.hostmanager.manage_host = false
      config.hostmanager.ignore_private_ip = false

      # Stop generation of keys & use insecure keys instead
      config.ssh.insert_key = false

      config.vm.define box do |host|
        host.vm.box = cfg[:box]
        host.hostmanager.aliases = "#{box}"
        host.vm.hostname = "#{box}"

        # Port forwarding, not needed?
        unless cfg[:portfwds].nil?
          cfg[:portfwds].each do |src, dst|
            host.vm.network "forwarded_port", guest: dst, host: src
          end
        end

        # Vmware
        host.vm.provider "vmware_desktop" do |vmw|
          vmw.gui = false
          vmw.vmx["numvcpus"] = 1
          vmw.vmx["memsize"] = 512
        end

        # Virtualbox
        host.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--memory", "512"]
          vb.customize ["modifyvm", :id, "--cpus", "1"]
        end

        host.vm.provision :hostmanager
        if box == "admnode"
          host.vm.provision :shell, path: "admnode.sh"
        end
      end
    end
end
