
# 1.7.2 Ensure local login warning banner is configured properly

{% set rule = '(1.7.2)' %}

{% set retval = salt['cmd.script']('salt://{}/files/1_7_audit'.format(slspath), cwd='/opt', args='/etc/issue') %}

{% if retval['stdout'] %}
{{ rule }} Ensure /etc/issue is configured correctly:
  file.managed:
    - name: /etc/issue
    - user: root
    - group: root
    - mode: "0644"
    - source: salt://{{ slspath }}/files/1_7_2_rem
{% endif %}