
{% set pkgs = salt['pkg.list_pkgs']() %}

{% if 'cronie' in pkgs %}

{% set rule = '(5.1.1) Ensure cron daemon is enabled' %}
{{ rule }}:
  service.running:
    - name: crond
    - enable: True

{% set rule = '(5.1.2) Ensure permissions on /etc/crontab are configured' %}
{{ rule }} :
  file.managed:
    - name: /etc/crontab
    - mode: "0600"
    - user: root
    - group: root
    - replace: False

{% set rules = {
  'cron.hourly':  '5.1.3', 
  'cron.daily':   '5.1.4', 
  'cron.weekly':  '5.1.5', 
  'cron.monthly': '5.1.6', 
  'cron.d':       '5.1.7'
} %}
  
{% for rule,number in rules.items() %}  
({{ number }}) Ensure permissions on /etc/{{ rule }} are configured:
  file.directory:
    - name: /etc/{{ rule }}
    - dir_mode: "0700"
    - user: root
    - group: root
{% endfor %}

{% set rule = '(5.1.8) Ensure cron is restricted to authorized users' %}
{{ rule }} - cron.allow:
  file.managed:
    - name: /etc/cron.allow
    - mode: "0600"
    - user: root
    - group: root

{{ rule }} - cron.deny:
  file.managed:
    - name: /etc/cron.deny
    - mode: "0600"
    - user: root
    - group: root
{% endif %}

{% if 'at' in pkgs %}
{% set rule = '(5.1.9) Ensure at is restricted to authorized users' %}
{{ rule }} - at.allow:
  file.managed:
    - name: /etc/at.allow
    - mode: "0600"
    - user: root
    - group: root

{{ rule }} - at.deny:
  file.managed:
    - name: /etc/at.deny
    - mode: "0600"
    - user: root
    - group: root
{% endif %}