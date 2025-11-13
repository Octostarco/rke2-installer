# Step 1: setup lvm
```
   22  lsblk
   23  pvcreate /dev/nvme0n1
   24  pvcreate /dev/nvme2n1
   25  pvcreate /dev/nvme3n1
   26  pvcreate /dev/nvme4n1
   27  pvcreate /dev/nvme5n1
   28  vgextend ubuntu-vg /dev/nvme0n1
   29  vgextend ubuntu-vg /dev/nvme2n1
   30  vgextend ubuntu-vg /dev/nvme3n1
   31  vgextend ubuntu-vg /dev/nvme4n1
   32  vgextend ubuntu-vg /dev/nvme5n1
```

# Step 2: setup ansible environment
```bash
python3 -m venv .venv
source .venv/bin/activate
ansible-galaxy collection install -r requirements.yml
```

# Step 3: run ansible playbook
```bash
ansible-playbook --extra-vars "target_host=octobox01" octobox.yml
```
