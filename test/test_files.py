import pytest

@pytest.mark.parametrize("name, user, group, mode, contains", [
  ("/etc/apt/sources.list.d/docker.list", "root", "root", "0644", "deb https://apt.dockerproject.org/repo"),
  ("/tmp/docker-lab/", "root", "root", "0755", "null"),
  ("/tmp/CV/", "root", "root", "0755", "null"),
  ("/usr/local/bin/docker-clean.sh", "root", "root", "0755", "/usr/bin/docker"),
])

def test_files(host, name, user, group, mode, contains):
  file = host.file(name)
  assert file.exists
  assert file.user == user
  assert file.group == group
  assert oct(file.mode) == mode
  if file.is_directory is not True:
    assert file.contains(contains)
  else:
    assert file.is_directory