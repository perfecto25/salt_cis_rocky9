{% set rule = '(1.7.3) Ensure remote login warning banner is configured properly' %}

{% set retval = salt['cmd.script']('salt://{}/files/1_7_audit'.format(slspath), cwd='/opt', args='/etc/issue.net') %}

{% if retval['stdout'] %}
{{ rule }} - /etc/issue.net:
  file.managed:
    - name: /etc/issue.net
    - user: root
    - group: root
    - mode: "0644"
    - source: salt://{{ slspath }}/files/1_7_2_rem
{% endif %}