### TIME SYNCHRONIZATION
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "2.1.1" in ignore %}
{% set rule = '(2.1.1) Ensure time synchronization is in use' %}
{{ rule }}:
  pkg.installed:
    - name: chrony
  service.running:
    - name: chronyd
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "2.1.2" in ignore %}
{% set rule = '(2.1.2) Ensure chrony is configured' %}
{{ rule }}:
  file.replace:
    - name: /etc/sysconfig/chronyd
    - pattern: ^OPTIONS=.*
    - repl: OPTIONS="-u chrony"
    - append_if_not_found: True
{% endif %} # "ignore"