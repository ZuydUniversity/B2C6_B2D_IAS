ansible_do_install() {
    # debian 12 ansible install

    pip install ansible[azure]
    pip install packaging
    ansible-galaxy collection install azure.azcollection --force
    pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt
}

ansible_install () {
  ansible-playbook

  # if ansible not found (exit code 127), do install
  if [ $? -eq 127 ]; then
    echo "[*] installing ansible"
    ansible_do_install
    echo "[+] installed ansible"
  else
    echo "[+] ansible installation found"
  fi
}

azure_login() {
    az login --service-principal --username $1 --password $2 --tenant $3
}

ansible_run_az_create_vm() {
    ansible-playbook Playbooks/azure/vm_create.yml -e "ansible_python_interpreter=$1/bin/python3"
}

export VENV_PATH="/tmp/ansible-venv"

python3 -m venv $VENV_PATH
source "$VENV_PATH/bin/activate"

ansible_install
azure_login 8cf2ed0e-9a0f-4fb5-aaa7-9514f4f8848a 'pk28Q~RWw7qOUdOTxzOGRWAQjvdWW-e.~RKGGbkz' 586e785a-8271-4fc6-a0c4-59fec8a68975
ansible_run_az_create_vm $VENV_PATH