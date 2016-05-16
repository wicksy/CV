docker-repo:
  pkgrepo.managed:
    - humanname: Docker Project
    - name: deb https://apt.dockerproject.org/repo ubuntu-trusty main
    - dist: ubuntu-trusty
    - file: /etc/apt/sources.list.d/docker.list
    - gpgcheck: 1
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - require_in:
      - pkg: docker-pkg

docker-pkg:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - docker-engine
    - require:
      - pkgrepo: docker-repo
      - sls: pkg

docker-service:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: docker-pkg

docker-github:
  git.latest:
    - name: https://github.com/wicksy/docker-lab.git
    - branch: develop
    - target: /tmp/docker-lab/
    - require:
      - service: docker-service

wicksy/base:latest:
  dockerng.image_present:
    - build: /tmp/docker-lab/base
    - require:
      - sls: pip
      - service: docker-service
      - git: docker-github

wicksy/wicksycv:latest:
  dockerng.image_present:
    - build: /tmp/docker-lab/wicksycv
    - force: True
    - require:
      - dockerng: wicksy/base:latest

CV-github:
  git.latest:
    - name: https://github.com/wicksy/CV.git
    - branch: master
    - target: /tmp/CV/
    - require:
      - dockerng: wicksy/wicksycv:latest

docker-clean-file:
  file.managed:
    - name: /usr/local/bin/docker-clean.sh
    - user: root
    - group: root
    - mode: 0755
    - source: salt://docker/files/docker-clean.sh
    - makedirs: True

docker-clean-exec:
  cmd.run:
    - name: /usr/local/bin/docker-clean.sh
    - require:
      - file: docker-clean-file

docker-run-wicksycv:
  dockerng.running:
    - name: wicksycv
    - image: wicksy/wicksycv:latest
    - ports:
      - "8080/tcp"
    - port_bindings: 8080:8080
    - binds: /tmp/CV/:/data/cv/
    - cmd: 'bash -c "cd /data/cv/mkdocs/CV && /usr/bin/mkdocs serve --dev-addr 0.0.0.0:8080 --theme readthedocs"'
    - require:
      - git: CV-github
      - cmd: docker-clean-exec
