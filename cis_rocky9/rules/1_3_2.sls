# 1.3.2 Ensure filesystem integrity is regularly checked

{% set rule = '(1.3.2)' %}
    
{% set crons = salt['cron.list_tab']('root')['crons'] %}
{% set cron_present = 'no' %}

{% for cron in crons %}
{% if 'aide' in cron['cmd'] %}
    {% set cron_present = 'yes' %}
{% endif %}
{% endfor %}

{% if cron_present == 'yes' %}
{{ rule }} ensure AIDE cron is present:
  test.succeed_without_changes:
    - name: AIDE cron is present
{% else %}
{{ rule }} ensure AIDE cron is present:
  cron.present:
    - name: /usr/sbin/aide --check
    - identifier: AIDE file integrity check
    - user: root
    - minute: 0
    - hour: 5
    - unless: crontab -l -u root | grep 'aide --check'
{% endif %}