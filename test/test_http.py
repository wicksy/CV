import pytest
import requests

@pytest.mark.parametrize("url", [
  ("http://192.168.168.192:8080/"),
])

def test_http(TestinfraBackend, url):
  response = requests.get(url)
  assert response.status_code == 200