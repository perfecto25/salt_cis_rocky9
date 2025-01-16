{% set rule = '(2.1.1) Ensure time synchronization is in use' %}

{{ rule }}:
  pkg.installed:
    - name: chrony
  service.running:
    - name: chronyd

{% set rule = '(2.1.2) Ensure chrony is configured' %}
{{ rule }}:
  file.replace:
    - name: /etc/sysconfig/chronyd
    - pattern: ^OPTIONS=.*
    - repl: OPTIONS="-u chrony"
    - append_if_not_found: True