{% set rule = '(1.6.1.6) Ensure no unconfined services exist' %}

{% set retval = salt['cmd.run_all'](cmd="ps -eZ | grep unconfined_service_t", python_shell=True)['stdout'] %}

{% if not retval %}
{{ rule }}:
  test.succeed_without_changes:
    - name: "{{ rule }} No unconfined daemons exist"
{% else %}
{{ rule }}:
  test.fail_without_changes:
    - name: "{{ rule }} unconfined daemons found: {{retval}} "
    
{% endif %}