#!/bin/bash -x
#
# Run Tests (post Travis build)
#

# Exit on errors
#
#set -e
#set -u
#set -o pipefail

# Wait for container to init
#
sleep 30

# Container state
#
docker ps

# Check HTTP end point (initial simple test to prove basic test)
#
export TEST_URL="http://localhost:8080"

curl "${TEST_URL}" \
  | grep 'Martin Wicks.*Curriculum Vitae'

exit 0
