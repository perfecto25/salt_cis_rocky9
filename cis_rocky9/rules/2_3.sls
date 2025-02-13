###  2.3 Service Clients
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "2.3" in ignore %}

{% set rule = '(2.3) Ensure pkg is not installed' %}
{% for pkg in [
  'telnet',
  'openldap-clients',
  'tftp',
  'ftp',
] 
%}

{% if pkg not in salt['pillar.get']('cis_rocky9:ignore:packages') %}
{{ rule }} - {{ pkg }}:
  pkg.removed:
    - name: {{ pkg }}
{% endif %}
{% endfor %}

{% endif %} # "ignore"