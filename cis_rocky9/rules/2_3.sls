# 2.3 Service Clients

{% set rule = '(2.3)' %}

{% for pkg in [
  'telnet',
  'openldap-clients',
  'tftp',
  'ftp',
] 
%}

{% if pkg not in salt['pillar.get']('cis:ignore:packages') %}

{{ rule }} ensure package {{ pkg }} is not installed:
  pkg.removed:
    - name: {{ pkg }}

{% endif %}
{% endfor %}