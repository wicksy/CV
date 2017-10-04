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
    - reload_modules: true
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

CV-github:
  git.latest:
    - name: https://github.com/wicksy/CV.git
    - branch: master
    - target: /tmp/CV/

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
      - service: docker-service
      - file: docker-clean-file

docker-buildrun-ansible:
  cmd.run:
    - name: ansible-playbook -i /srv/ansible/hosts --limit localhost /srv/ansible/CV.yml -v
    - require:
      - sls: pip
      - sls: ansible
