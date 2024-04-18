# 1.6.1.6 Ensure no unconfined services exist

{% set rule = '(1.6.1.6)' %}

{% set retval = salt['cmd.run_all'](cmd="ps -eZ | grep unconfined_service_t", python_shell=True)['stdout'] %}

{% if not retval %}
{{ rule }} Ensure no unconfied daemons exist:
  test.succeed_without_changes:
    - name: "{{ rule }} No unconfined daemons exist"
{% else %}
{{ rule }} Ensure no unconfined daemons exist:
  test.fail_without_changes:
    - name: "{{ rule }} unconfined daemons found: {{retval}} "
    
{% endif %}