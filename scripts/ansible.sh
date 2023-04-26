#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TEXT_COLOR="\033[1;34m"
NO_COLOR="\033[0m"

echo -e "${TEXT_COLOR}Installing ansible dependencies${NO_COLOR}"
ansible-galaxy install -r "$SCRIPT_DIR/../ansible/requirements.yml"

echo -e "${TEXT_COLOR}Executing ansible playbook${NO_COLOR}"
ansible-playbook "$SCRIPT_DIR/../ansible/work.yml" --ask-become-pass

echo -e "${TEXT_COLOR}Setup complete${NO_COLOR}"
