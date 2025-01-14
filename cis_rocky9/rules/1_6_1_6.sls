# 1.6.1.6 Ensure no unconfined services exist

# Description:
# Unconfined processes run in unconfined domains

# Rationale:
# For unconfined processes, SELinux policy rules are applied, but policy rules exist that
# allow processes running in unconfined domains almost all access. Processes running in
# unconfined domains fall back to using DAC rules exclusively. If an unconfined process
# is compromised, SELinux does not prevent an attacker from gaining access to system
# resources and data, but of course, DAC rules are still used. SELinux is a security
# enhancement on top of DAC rules – it does not replace them

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