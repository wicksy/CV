{%- if salt['pillar.get']('pip:installed') %}
  {%- for pip in salt['pillar.get']('pip:installed') %}
pip-{{ pip }}-installed:
  pip.installed:
    - name: {{ pip }}
    - upgrade: False
    - require:
      - sls: pkg
  {% endfor %}
{%- endif %}
