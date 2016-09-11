import pytest

@pytest.mark.parametrize("name, enabled, running", [
  ("docker", "enabled", "running"),
])

def test_services(Service, name, enabled, running):
  is_enabled = Service(name).is_enabled
  if enabled == "enabled":
    assert is_enabled
  else:
    assert not is_enabled

  is_running = Service(name).is_running
  if running == "running":
    assert is_running
  else:
    assert not is_running

