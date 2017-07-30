import os
import pytest

TEST_URL = str(os.environ.get('TEST_URL'))
if TEST_URL != 'None' and TEST_URL.strip():
  pass
else:
  TEST_URL="http://192.168.168.192:8080/"

@pytest.mark.parametrize("command", [
  ("sudo docker ps -f name=wicksycv | grep wicksycv"),
  ("curl " + TEST_URL + " | grep 'Martin Wicks.*Curriculum Vitae'"),
])

def test_commands(host, command):
  cmd = host.run(command)
  assert cmd.rc == 0