#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TEXT_COLOR="\033[1;34m"
NO_COLOR="\033[0m"

if [[ -z "$INVENTORY" ]]; then
  read -p "Enter the inventory to deploy to [home]: " INVENTORY
  INVENTORY=${INVENTORY:-home}
else
  echo "Enter the inventory to deploy to [$INVENTORY]: $INVENTORY"
fi

if [[ -z "$WORK_NAME" ]]; then
  read -p "Enter your preferred full name: " WORK_NAME
  export WORK_NAME
else
  echo "Enter your preferred full name: $WORK_NAME"
fi

if [[ -z "$WORK_EMAIL" ]]; then
  read -p "Enter your work email: " WORK_EMAIL
  export WORK_EMAIL
else
  echo "Enter your work email: $WORK_EMAIL"
fi

if [[ -z "$MAS_EMAIL" ]]; then
  read -p "Enter your App Store email: " MAS_EMAIL
  export MAS_EMAIL
else
  echo "Enter your App Store email: $MAS_EMAIL"
fi

if [[ -z "$WORK_GPG_KEY" ]]; then
  read -p "Enter your GPG key for signing commits: " WORK_GPG_KEY
  export WORK_GPG_KEY
else
  echo "Enter your GPG key for signing commits: $WORK_WORK_GPG_KEY"
fi

echo -e "${TEXT_COLOR}Installing python dependencies${NO_COLOR}"
poetry install --no-root

echo -e "${TEXT_COLOR}Installing ansible dependencies${NO_COLOR}"
poetry run ansible-galaxy install -r "$SCRIPT_DIR/../ansible/requirements.yml"

echo -e "${TEXT_COLOR}Executing ansible playbook for ${INVENTORY}${NO_COLOR}"
poetry run ansible-playbook "$SCRIPT_DIR/../ansible/setup.yml" --ask-become-pass -i "$SCRIPT_DIR/../ansible/inventory/$INVENTORY.yml"

echo -e "${TEXT_COLOR}Setup complete${NO_COLOR}"
