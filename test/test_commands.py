import os
import pytest

TEST_URL = str(os.environ.get('TEST_URL'))
if TEST_URL != 'None' and TEST_URL.strip():
  pass
else:
  TEST_URL="http://192.168.168.192:8080/"

@pytest.mark.parametrize("command, rc", [
  ("sudo docker ps -f name=wicksycv | grep wicksycv", 0),
  ("curl " + TEST_URL + " | grep 'Martin Wicks.*Curriculum Vitae'", 0),
])

def test_commands(Command, command, rc):
  assert Command(command).rc == rc