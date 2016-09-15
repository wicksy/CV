import pytest

@pytest.mark.parametrize("command, rc", [
  ("sudo docker ps -f name=wicksycv | grep wicksycv", 0),
  ("curl http://192.168.168.192:8080 | grep 'Martin Wicks.*Curriculum Vitae'", 0),
])

def test_commands(Command, command, rc):
  assert Command(command).rc == rc