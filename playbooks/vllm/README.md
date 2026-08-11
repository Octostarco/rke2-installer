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
   33  lvresize -l +100%FREE --resizefs ubuntu-vg/ubuntu-lv
```

# Step 2: setup ansible environment
```bash
python3 -m venv .venv
source .venv/bin/activate
ansible-galaxy collection install -r requirements.yml
```

# Step 3: run ansible playbook
```bash
ansible-playbook -i inventory --extra-vars "target_host=octobox03" octobox.yml
```

## Running against EC2

The play autodetects EC2 from the SMBIOS vendor and adjusts three things: it
skips the nvidia driver install (the DLAMI already ships a newer driver), skips
the whole `dummy0` workaround along with the `network-manager` package, and
advertises the instance's real ENI IP instead of the hardcoded `172.31.255.1`.

Force it either way if the detection is wrong:

```bash
ansible-playbook -i inventory --extra-vars "target_host=... octobox_is_ec2=true" octobox.yml
```

## The served model

The play serves **qwen36** (`Qwen/Qwen3.6-27B-FP8`) and, on each run, deletes the
`qwen3`, `qwen35` and `phi35` Deployments and Services it replaces.

Two things to know before running it against a box that is already serving:

- **The old service names go away.** In-cluster callers must move from
  `qwen35.vllm.svc` to `qwen36.vllm.svc`, and requests sending `"model":
  "qwen35"` need updating too. There is no alias or compatibility Service — the
  old names are deleted in the same run that creates qwen36, and qwen36 takes
  10+ minutes to become ready (hours if it still has to download the weights),
  so plan for that window.
- **The old PVCs are kept.** `qwen35-pvc`, `qwen3-pvc` and `phi35-pvc` are left
  behind so their weights are not thrown away, but nothing uses them once the
  cutover is done. They are 100Gi each on `local-path`, on the same volume
  qwen36 downloads into — delete them by hand when you are sure you will not
  roll back.
