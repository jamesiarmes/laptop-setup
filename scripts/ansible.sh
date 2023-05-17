#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TEXT_COLOR="\033[1;34m"
NO_COLOR="\033[0m"

echo -e "${TEXT_COLOR}Installing python dependencies${NO_COLOR}"
poetry install

echo -e "${TEXT_COLOR}Installing ansible dependencies${NO_COLOR}"
poetry run ansible-galaxy install -r "$SCRIPT_DIR/../ansible/requirements.yml"

echo -e "${TEXT_COLOR}Executing ansible playbook${NO_COLOR}"
poetry run ansible-playbook "$SCRIPT_DIR/../ansible/setup.yml" --ask-become-pass -i "$SCRIPT_DIR/../ansible/inventory/home.yml"

echo -e "${TEXT_COLOR}Setup complete${NO_COLOR}"
