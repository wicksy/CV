import pytest

@pytest.mark.parametrize("name, user, group, mode, contains", [
  ("/etc/apt/sources.list.d/docker.list", "root", "root", "0644", "deb https://apt.dockerproject.org/repo"),
  ("/tmp/docker-lab/", "root", "root", "0755", "null"),
  ("/tmp/CV/", "root", "root", "0755", "null"),
  ("/usr/local/bin/docker-clean.sh", "root", "root", "0755", "/usr/bin/docker"),
])

def test_files(File, name, user, group, mode, contains):
  assert File(name).exists
  assert File(name).user == user
  assert File(name).group == group
  assert oct(File(name).mode) == mode
  if File(name).is_directory is not True:
    assert File(name).contains(contains)
  else:
    assert File(name).is_directory