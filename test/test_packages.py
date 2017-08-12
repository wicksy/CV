import pytest

@pytest.mark.parametrize("name", [
  ("git"),
  ("python2.7"),
  ("apt-transport-https"),
  ("ca-certificates"),
  ("docker-ce"),
  ("salt-minion"),
  ("salt-common"),
  ("software-properties-common"),
])

def test_packages(host, name):
  pkg = host.package(name)
  assert pkg.is_installed