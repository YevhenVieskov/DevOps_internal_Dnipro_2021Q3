#!bin/bash
#set -e # Exit on first error
set -x # Print expanded commands to stdout

#install git
apt install -y git

#install ansible
apt-add-repository -y ppa:ansible/ansible
apt update
apt install -y ansible

cd ~
git clone https://github.com/YevhenVieskov/DevOps_internal_Dnipro_2021Q3.git


#install docker
cp -r ~/DevOps_internal_Dnipro_2021Q3/ansible/install_docker ~/.ansible/roles
cp  ~/DevOps_internal_Dnipro_2021Q3/ansible/install_docker.yml ~/.ansible/
ansible-playbook ~/.ansible/install_docker.yml

