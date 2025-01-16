{% set rule = '(1.7.1) Ensure MOTD is configured properly' %}

{% set retval = salt['cmd.script']('salt://{}/files/1_7_audit'.format(slspath), cwd='/opt', args='/etc/motd') %}

{% if retval['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "{{ rule }} /etc/motd contains OS release information"
{% endif %}
