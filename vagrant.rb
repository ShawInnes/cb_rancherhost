Vagrant.configure("2") do |config|
  if !Vagrant.has_plugin?("vagrant-triggers")
    puts "The 'vagrant-triggers' plugin is required."
    puts "It can be installed by running: vagrant plugin install vagrant-triggers"
    puts
    exit
  end

  if ENV['RHN_USERNAME'] and ENV['RHN_PASSWORD'] then
    config.vm.provision "shell",
      upload_path: '/home/packer/vagrant-shell',
      inline: <<-SHELL
      yum remove -y "katello-ca-consumer*"
      mv -f /etc/rhsm/rhsm.conf.kat-backup /etc/rhsm/rhsm.conf
      subscription-manager register --username '#{ENV['RHN_USERNAME']}' --password '#{ENV['RHN_PASSWORD']}' --auto-attach
      subscription-manager repos --disable=rhel-7-server-rt-beta-rpms
    SHELL

    config.trigger.before :destroy, :stdin => false, :stdout => false do
      info "Removing RHN Subscription"
      run_remote "subscription-manager remove --all; subscription-manager unregister; subscription-manager clean; exit 0;"
    end
  end
end
