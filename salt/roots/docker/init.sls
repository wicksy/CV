docker-key:
  cmd.run:
    - name: curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

docker-repo:
  pkgrepo.managed:
    - humanname: Docker Project
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/docker.list
    - gpgcheck: 1
    - require_in:
      - pkg: docker-pkg

docker-pkg:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - software-properties-common
      - docker-ce
    - require:
      - pkgrepo: docker-repo
      - cmd: docker-key
      - sls: pip
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
  docker_image.present:
    - build: /tmp/docker-lab/base
    - require:
      - sls: pip
      - service: docker-service
      - git: docker-github

wicksy/wicksycv:latest:
  docker_image.present:
    - build: /tmp/docker-lab/wicksycv
    - force: True
    - require:
      - docker_image: wicksy/base:latest

CV-github:
  git.latest:
    - name: https://github.com/wicksy/CV.git
    - branch: master
    - target: /tmp/CV/
    - require:
      - docker_image: wicksy/wicksycv:latest

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

  docker_container.running:
    - name: wicksycv
    - image: wicksy/wicksycv:latest
    - ports:
      - "8080/tcp"
    - port_bindings: 8080:8080
    - binds: /tmp/CV/:/data/cv/
    - cmd: 'bash -c "cd /data/cv/mkdocs && /usr/bin/mkdocs serve --dev-addr 0.0.0.0:8080 --theme material"'
    - require:
      - git: CV-github
      - cmd: docker-clean-exec
