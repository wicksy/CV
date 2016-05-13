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
    - require:
      - dockerng: wicksy/base:latest

CV-github:
  git.latest:
    - name: https://github.com/wicksy/CV.git
    - branch: master
    - target: /tmp/CV/
    - require:
      - dockerng: wicksy/wicksycv:latest

docker-run-wicksycv:
  dockerng.running:
    - image: wicksy/wicksycv:latest
    - port_bindings: 8080:8080
    - binds: /tmp/CV/:/data/cv/
    - command: "sleep 120"
    - require:
      - git: CV-github
