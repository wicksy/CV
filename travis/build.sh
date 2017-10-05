#!/bin/bash -x
#
# Build - Apply Salt States
#

# Exit on errors
#
set -e
set -u
set -o pipefail

# Create Salt Links for States and Pillar
# and link for Ansible
#
mkdir -p /srv
ln -sf "$(pwd)/salt/roots" /srv/salt
ln -sf "$(pwd)/salt/pillar" /srv/pillar
ln -sf "$(pwd)/ansible" /srv/ansible

# Apply States
#
salt-call --local -l debug state.apply

exit 0
