import pytest

@pytest.mark.parametrize("name", [
  ("git"),
  ("python2.7"),
  ("python-pip"),
  ("apt-transport-https"),
  ("ca-certificates"),
  ("docker-engine"),
  ("salt-minion"),
  ("salt-common"),
])

def test_packages(Package, name):
  assert Package(name).is_installed