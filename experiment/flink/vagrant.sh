# install vagrant on windows | macos
wget https://releases.hashicorp.com/vagrant/2.4.0/vagrant_2.4.0_windows_amd64.msi

# integrate vmware
#vagrant plugin uninstall vagrant-vmware-desktop
#dpkg -r vagrant-vmware-utility
wget https://releases.hashicorp.com/vagrant-vmware-utility/1.0.22/vagrant-vmware-utility_1.0.22_windows_amd64.msi

vagrant plugin install vagrant-vmware-desktop --plugin-clean-sources --plugin-source https://gems.ruby-china.com/ --debug
#vagrant plugin uninstall vagrant-vbguest
#vagrant plugin install vagrant-vbguest --plugin-clean-sources --plugin-source https://gems.ruby-china.com/ --debug

# vagrant dependency virtualbox,
# vagrant plugin install vagrant-cachier
# vagrant plugin install vagrant-faster
# vagrant plugin uninstall vagrant-faster
# vagrant plugin uninstall   vagrant-vbguest
# vagrant plugin install   vagrant-vbguest --plugin-version 0.24.0.beta1
# or this version:
#vagrant plugin uninstall vagrant-vbguest
#vagrant plugin install vagrant-vbguest --plugin-version 0.21


vagrant init
# default download box to ~/.vagrant.d/boxes, can copy to each other
# remember to set HTTP_PROXY="http://127.0.0.1:51134"  HTTPS_PROXY="http://127.0.0.1:51134" ENVIRONMENT
$env:HTTP_PROXY="http://127.0.0.1:51134"
$env:HTTPS_PROXY="http://127.0.0.1:51134"

# 为了需要用到vagrant disk 配置, 需要开启disk实验性功能
[Environment]::SetEnvironmentVariable('VAGRANT_EXPERIMENTAL', 'disks' , 'User')

# update for your environment:  config.vm.provider, config.vm.network bridge, config.vm.synced_folder
netstat -ntlp | grep ":80 " | awk '{print $7}' | awk -F"/" '{print $1}'|xargs kill
netstat -ntlp | grep ":6443 " | awk '{print $7}' | awk -F"/" '{print $1}'|xargs kill
# if you have conflict the port, please delete the virtual machine
vagrant up
#vagrant rsync-auto

vagrant rsync

vagrant status

vagrant ssh
# default login user/password is vagrant/vagrant， su root to switch to root user


# reload
vagrant reload
# run below command to stop
vagrant halt
# run below command to destroy
vagrant destroy -f


# 需要手动