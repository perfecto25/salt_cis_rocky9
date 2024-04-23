# 1.7.1  Ensure message of the day is configured properly

{% set rule = '(1.7.1)' %}


{% set retval = salt['cmd.script']('salt://{}/files/1_7_audit'.format(slspath), cwd='/opt', args='/etc/motd') %}

{% if retval['stdout'] %}
{{ rule }} Ensure /etc/motd is configured correctly:
  test.fail_without_changes:
    - name: "{{ rule }} /etc/motd contains OS release information"
{% endif %}
