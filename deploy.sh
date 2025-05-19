#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ $# -eq 0 ]; then
    >&2 echo "No arguments provided. Usage: deploy.sh <inventory>"
    exit 1
fi

set -e

INVENTORY="${SCRIPT_DIR}/inventories/${1}"

if [ ! -f "${INVENTORY}" ]
then
    echo "${INVENTORY} does not exist, exiting"
    exit 1
else
    echo "Using inventory ${INVENTORY}..."
fi

echo "Installing ansible roles..."
ansible-galaxy install -r requirements.yml

echo "Deploying..."
ansible-playbook "playbooks/playbook.yml" -i "${INVENTORY}"