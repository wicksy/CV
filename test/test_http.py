import os
import pytest
import requests

TEST_URL = str(os.environ.get('TEST_URL'))
if TEST_URL != 'None' and TEST_URL.strip():
  pass
else:
  TEST_URL="http://192.168.168.192:8080/"

@pytest.mark.parametrize("url", [
  (TEST_URL),
])

def test_http(host, url):
  response = requests.get(url)
  assert response.status_code == 200