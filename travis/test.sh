#!/bin/bash -x
#
# Run Tests (post Travis build)
#

# Exit on errors
#
set -e
set -u
set -o pipefail

# Pick up path to testinfra passed in
#
TESTINFRA="${1:-testinfra}"

# Define tests
#
tests="test/test_packages.py \
       test/test_services.py \
       test/test_files.py \
       test/test_http.py \
       test/test_commands.py"

# Wait for container to init
#
sleep 30

# Set HTTP End Point for container running on Travis CI 
#
export TEST_URL="http://localhost:8080"

# Run test pack
#
"${TESTINFRA}" --sudo --sudo-user=root -v ${tests}

# Exit 0 as if we've got here we're generally all good
#
exit 0
