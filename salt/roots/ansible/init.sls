ansible-user:
  user.present:
    - name: ansible
    - fullname: Ansible User
    - shell: /bin/bash
    - home: /home/ansible
    - createhome: True

ansible-sshkeys:
  cmd.run:
    - name: ssh-keygen -q -N '' -f /home/ansible/.ssh/id_rsa
    - runas: ansible
    - unless: test -f /home/ansible/.ssh/id_rsa

ansible-authorized-keys:
  ssh_auth.present:
    - user: ansible
    - enc: ssh-rsa
    - source: /home/ansible/.ssh/id_rsa.pub
