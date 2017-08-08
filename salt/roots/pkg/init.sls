{%- if salt['pillar.get']('pkg:installed') %}
pkg-installed:
  pkg.installed:
    - pkgs:
  {%- for pkg in salt['pillar.get']('pkg:installed') %}
      - {{ pkg }}
  {% endfor %}
{%- endif %}

pkg-python-pip:
  cmd.run:
    - name: easy_install --script-dir=/usr/bin -U pip
    - cwd: /
    - reload_modules: true
