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

def test_packages(host, name):
  pkg = host.package(name)
  assert pkg.is_installed