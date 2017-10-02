import pytest

@pytest.mark.parametrize("name", [
  ("ansible"),
  ("docker-py"),
  ("mkdocs"),
  ("mkdocs-material"),
  ("pyOpenSSL"),
])

def test_pips(host, name):
  assert name in host.pip_package.get_packages()