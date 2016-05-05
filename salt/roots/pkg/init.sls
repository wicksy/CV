{%- if salt['pillar.get']('pkg:installed') %}
pkg-pkg-installed:
  pkg.installed:
    - pkgs:
  {%- for pkg in salt['pillar.get']('pkg:installed') %}
      - {{ pkg }}
  {% endfor %}
{%- endif %}
