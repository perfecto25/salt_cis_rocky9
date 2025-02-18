## AUTHSELECT config

{% set rule = '(5.4.1) Ensure custom authselect profile is used' %}
{% set ret = salt['cmd.run_all']("authselect list | grep '^-\s*custom'", python_shell=True) %}
{% if not ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: Authselect does not have a custom profile enabled
{% endif %}

{% set rule = '(5.4.2) Ensure authselect includes with-faillock' %}
{{ rule }} - password-auth:
  file.managed:
    - name: /etc/pam.d/password-auth
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - source: salt://{{ slspath }}/files/5_4_password_auth.j2
    - template: jinja

{{ rule }} - system-auth:
  file.managed:
    - name: /etc/pam.d/system-auth
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - source: salt://{{ slspath }}/files/5_4_system_auth.j2
    - template: jinja

