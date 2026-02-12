
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/jammy64"

  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 8080, host: 811

  config.vm.network "private_network", ip: "192.168.33.12"
  config.vm.synced_folder "../app", "/opt/project"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.name = "srv-web"

    vb.memory = "1024"
    vb.cpus = 2
  end

  # Copier le script de déploiement
  config.vm.provision "file", source: "deploy.sh", destination: "/tmp/deploy.sh"
  
  # Rendre le script exécutable et le placer dans /opt
  config.vm.provision "shell", inline: "chmod +x /tmp/deploy.sh && mv /tmp/deploy.sh /opt/deploy.sh && echo '✅ Script de déploiement installé dans /opt/deploy.sh'"
  
end
