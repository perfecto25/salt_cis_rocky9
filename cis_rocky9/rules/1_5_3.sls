# 1.5.3 Ensure address space layout randomization (ASLR) is enabled

{% set rule = '(1.5.3)' %}

{% set result = salt['cmd.script']('salt://{}/files/1_5_3_audit'.format(slspath), cwd='/opt') %}

{% if result['stdout'] == "1" %}

{{ rule }} xxx:
  test.fail_without_changes:
    - name: FAIL 
{% else %}
{{ rule }} xxx:
  test.succeed_without_changes:
    - name: Pass 
{% endif %}
