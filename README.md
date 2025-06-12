# Octostar Ansible RKE2

Octostar RKE2 K8s cluster installer with Ansible.

## Requirements

The only supported OS on cluster nodes is Ubuntu 24.04. Make sure to also follow the [RKE2 Requirements](https://docs.rke2.io/install/requirements) before you start.

### 1. Add SSH Private Key

1. Have an SSH key pair and have the public key added to the `authorized_keys` file on all the cluster nodes.

2. Have your SSH private key stored somewhere on your machine (e.g. in `/path/to/key`) and make sure it is readable only by the current user:

    ```
    chmod 600 /path/to/key
    ```

3. Edit `ansible.cfg` and set the path to your SSH private key:

    ```
    private_key_file = /path/to/key
    ```

### 2. Setup your environment

1. Install Ansible (see [Ansible docs](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) for more information)

2. Add Ansible roles:

    ```
    ansible-galaxy install -r requirements.yml
    ```

## Usage

1. Create a copy of the inventory `template.ini`, name it `<env>.ini` (e.g. `test.ini`), and edit the file filling in the correct values:

    ```
    cp inventories/template.ini inventories/test.ini
    ```

2. Run the playbook

    ```
    ./deploy.sh test.ini
    ```

    > Note: The RKE2 control plane nodes need ports 6443 and 9345 to be accessible by other nodes in the cluster.
