docker-pkg-repo:
  pkgrepo.managed:
    - humanname: Docker Project
    - name: deb https://apt.dockerproject.org/repo ubuntu-trusty main
    - dist: ubuntu-trusty
    - file: /etc/apt/sources.list.d/docker.list
    - gpgcheck: 1
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - require_in:
      - pkg: docker-pkg-installed

docker-pkg-installed:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - docker-engine
    - require:
      - pkgrepo: docker-pkg-repo
      - sls: pkg
