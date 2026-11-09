Prepares an octobox for GPU workloads: the NVIDIA drivers and container toolkit, k3s with the nvidia runtime as its default, and the NVIDIA device plugin.

It does not deploy vLLM. octostar-singlenode does, from the profile named by `vllm.profile` in its `local-env.yaml` (qwen36, qwen3635 or qwen3827); its README-GPU.md describes the profiles, and how it adopts a vLLM this playbook deployed before.

## Setup ansible environment
```bash
python3 -m venv .venv
source .venv/bin/activate
ansible-galaxy collection install -r requirements.yml
```

## Run ansible playbook

```bash
ansible-playbook -i inventory --extra-vars "target_host=octobox03" octobox.yml
```
