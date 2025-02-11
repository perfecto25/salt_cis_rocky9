{% set rule = '(3.1.2) Ensure wireless interfaces are disabled' %}


{% set retval = salt['cmd.script']('salt://{}/files/3_1_2_audit'.format(slspath), cwd='/opt') %}
{% do salt.log.error(retval) -%}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/3_1_2_rem
    - cwd: /opt
{% endif %}
