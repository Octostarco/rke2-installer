## Setup ansible environment
```bash
python3 -m venv .venv
source .venv/bin/activate
ansible-galaxy collection install -r requirements.yml
```

## Run ansible playbook

```
```
```bash
ansible-playbook -i inventory --extra-vars "target_host=octobox03" octobox.yml
```

To expose the vLLM API externally via NodePort (default port 30035):
```bash
ansible-playbook -i inventory --extra-vars "target_host=octobox03 vllm_expose=true" octobox.yml
```

The API will be available at `http://<octobox-ip>:30035/v1`.
