## AUTHSELECT config

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "5.4.1" in ignore %}
{% set rule = '(5.4.1) Ensure custom authselect profile is used' %}
{% set ret = salt['cmd.run_all']("authselect list | grep '^-\s*custom'", python_shell=True) %}
{% if not ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: Authselect does not have a custom profile enabled
{% endif %}
{% endif %}

# -----------------------------------

{% if not "5.4.2" in ignore %}
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
{% endif %}
