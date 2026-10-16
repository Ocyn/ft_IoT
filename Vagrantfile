K3S_TOKEN = "test"
#  TODO change to 192.158.56.XX
SERVER_IP = "192.168.57.110"
SERVER_WORKER_IP = "192.168.57.111"


Vagrant.configure(2) do |config|

	config.vm.box = "debian/trixie64"
	config.vm.box_version = "13.20260519.1"
	# config.vm.provider "libvirt" do |v|
	# end

	config.vm.provision "file",
		source: "~/.ssh/id_ed25519.pub",
		destination: "~/.ssh/authorized_keys"

	config.vm.provision "shell",
		path: "./utils/global_setup.sh"

	config.vm.define "jcuzinS" do |control|
		control.vm.hostname = "jcuzinS"
		control.vm.network "private_network",
		
		 ip: SERVER_IP
		control.vm.provider "libvirt" do |v|
			v.cpus = 1
			v.memory = 1024
		end
		# control.vm.provision "shell",
		# path: "./utils/S_setup_server.sh", 
		# args: [SERVER_IP, K3S_TOKEN]
		control.vm.provision "shell" do |s|
			s.path = "./utils/S_setup_server.sh"
			s.args = [SERVER_IP, K3S_TOKEN]
		end

	end

	config.vm.define "jcuzinSW" do |control|
		control.vm.hostname = "jcuzinSW"
		control.vm.network "private_network",
		#  TODO change to 192.158.56.111
		 ip: SERVER_WORKER_IP
		control.vm.provider "libvirt" do |v|
			v.cpus = 2
			v.memory = 2048 
		end
		# control.vm.provision "shell",
		# path: "./utils/SW_setup_agent.sh"
		# args: [SERVER_IP, K3S_TOKEN]
		control.vm.provision "shell" do |s|
			s.path = "./utils/SW_setup_agent.sh"
			s.args = [SERVER_IP, K3S_TOKEN]
		end
	end

end



# 42 EXEMPLE
# Vagrant.configure(2) do |config|
# 	[...]
# 	config.vm.box = REDACTED
# 	config.vm.box_url = REDACTED

# 	config.vm.define "wilS" do |control|
# 		control.vm.hostname = "wilS"
# 		control.vm.network REDACTED, ip: "192.168.56.110"
# 		control.vm.provider REDACTED do |v|
# 		v.customize ["modifyvm", :id, "--name", "wilS"]
# 		[...]
# 	end
# 	config.vm.provision :shell, :inline => SHELL
# 		[...]
# 		SHELL
# 		control.vm.provision "shell", path: REDACTED
# 	end
# 	config.vm.define "wilSW" do |control|
# 		control.vm.hostname = "wilSW"
# 		control.vm.network REDACTED, ip: "192.168.56.111"
# 		control.vm.provider REDACTED do |v|
# 		v.customize ["modifyvm", :id, "--name", "wilSW"]
# 		[...]
# 	end
# 	config.vm.provision "shell", inline: <<-SHELL
# 		[..]
# 		SHELL
# 		control.vm.provision "shell", path: REDACTED
# 	end
# end