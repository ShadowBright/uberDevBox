# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

disk = 'secondDisk.vdi'
machineName = `date +"Ubu17Dev_%Y%m%d%H%M%S"`

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/zesty64" 
    #config.vm.box = "zesty64"
    #config.vm.box_url = "https://cloud-images.ubuntu.com/zesty/current/zesty-server-cloudimg-amd64-vagrant.box"
    #config.ssh.username = 'vagrant'
    #config.ssh.password = 'vagrant'
    #config.ssh.insert_key = 'true'

    #config.vm.box = "xenial64"
    #config.vm.box_url = "https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box"
  	
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.provider "virtualbox" do |vb|
	vb.memory = 8096    
        vb.cpus = 4
        vb.gui = true
        vb.name = machineName 
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
        vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--vram", "128"]
        vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
        vb.customize ["modifyvm", :id, "--pae", "on"]
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.customize ["modifyvm", :id, "--nestedpaging", "on"]
        vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
        vb.customize ["modifyvm", :id, "--usb", "on"]
        vb.customize ["modifyvm", :id, "--usbehci", "on"]
    end

         # Syncfolders                                                         
         config.vm.synced_folder "downloads/", "/opt/downloads/"                
         config.vm.synced_folder "workspace/", "/opt/workspace/"                
         config.vm.synced_folder "documents/", "/opt/documents/"                

        #config.vm.provision :shell do |shell|
        #    shell.inline = "sudo chsh -s /bin/bash vagrant"
        #end

        config.vm.provision :shell, :path => "scripts/setup.sh"

        config.vbguest.auto_update = true
        config.vbguest.no_remote = false
end
