## PAM config

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "5.5.1" in ignore %}
{% set rule = '(5.5.1) Ensure password creation requirements are configured' %}
{{ rule }} - :
  file.managed:
    - name: /etc/security/pwquality.conf
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - source: salt://{{ slspath }}/files/5_5_pwquality.j2
    - template: jinja
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.5.2" in ignore %}
{% set rule = '(5.5.2) Ensure lockout for failed password attempts is configured' %}
{{ rule }}:
  file.managed:
    - name: /etc/security/faillock.conf
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - source: salt://{{ slspath }}/files/5_5_faillock.j2
    - template: jinja
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.5.4" in ignore %}
{% set rule = '(5.5.4) Ensure password hashing algorithm is SHA-512 or yescrypt' %}
{{ rule }} - libuser.conf:
  file.replace:
    - name: /etc/libuser.conf
    - pattern: "^crypt_style.*"
    - repl: crypt_style = sha512 
    - append_if_not_found: True

{{ rule }} - login.defs:
  file.replace:
    - name: /etc/login.defs
    - pattern: "^ENCRYPT_METHOD.*"
    - repl: ENCRYPT_METHOD SHA512
    - append_if_not_found: True
{% endif %}