#!/bin/bash

set -e

# Install tmate on macOS or Ubuntu
echo Setting up tmate...
if [ -x "$(command -v brew)" ]; then
  brew install tmate > /tmp/brew.log
elif [ -x "$(command -v apt-get)" ]; then
  sudo apt-get install -y tmate openssh-client > /tmp/apt-get.log
else
  echo System is not supported!
  exit 1
fi

# Generate ssh key if needed
[ -e ~/.ssh/id_rsa ] || ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""

# Run deamonized tmate
echo Running tmate...
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

# Print connection info
echo ----------------------------------------------------------------------
echo To connect to this session copy-n-paste the following into a terminal:
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
tmate -S /tmp/tmate.sock display -p '#{tmate_web}'
echo After connecting you can run touch /tmp/cancel to cancel the workflow
echo ----------------------------------------------------------------------