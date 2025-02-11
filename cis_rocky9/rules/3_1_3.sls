{% set rule = '(3.1.3) Ensure TIPC is disabled' %}

{% set retval = salt['cmd.script']('salt://{}/files/3_1_3_audit'.format(slspath), cwd='/opt') %}

{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/3_1_3_rem
    - cwd: /opt
{% endif %}
