# -*- mode: ruby -*-
# vi: set ft=ruby :

MACHINES = {
  'admnode' => {
    :box => 'chef/centos-7.0',
  },
  'n1' => {
    :box => 'chef/centos-7.0',
  },
  'n2' => {
    :box => 'chef/centos-7.0',
  },
}

Vagrant.configure(2) do |config|
  # Stop generation of keys & use insecure keys instead
  config.ssh.insert_key = false

  MACHINES.each do |box, cfg|
    config.vm.define box do |host|

      host.vm.box = cfg[:box]
      host.vm.hostname = "#{box}"

      # Setup networking based on provider
      provider = (ENV['VAGRANT_DEFAULT_PROVIDER'] || :virtualbox).to_sym
      case provider
      when :virtualbox
        host.vm.network "private_network", type: "dhcp"
      when :vmware_workstation
      end

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

      # Admnode specific provisioning
      if box == "admnode"
        host.vm.provision :shell, path: "admnode.sh"
      end

      # Hostmanager
      host.hostmanager.enabled = true
      host.hostmanager.manage_host = false
      host.hostmanager.ignore_private_ip = false
      host.hostmanager.ip_resolver = proc do |machine|
        result = []
        machine.communicate.execute("ip a") do |type, data|
          result = data.split("\n") if type == :stdout
        end
        ip_rows = result.select { |item| item[/inet (\d+\.\d+\.\d+\.\d+)/] }
        ip_rows.last.split(' ')[1].split('/')[0]
      end
      host.vm.provision :hostmanager

    end
  end
end
