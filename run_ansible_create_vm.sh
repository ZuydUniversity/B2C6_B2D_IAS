# debian 12 ansible install

ansible_install() {
    # add ansible apt repo
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/ansible.list
    sudo apt update
    
    # install ansible
    sudo apt install ansible

    pipx install ansible[azure]
}

ansible_run() {
    ansible-playbook Playbooks/azure/vm_create.yml
}

ansible_install
ansible_run