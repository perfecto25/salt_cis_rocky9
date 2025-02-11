# 1.9 Ensure updates, patches, and additional security software are installed


{% set rule = '(1.9)' %}

{% set result = salt['cmd.run_all']("dnf needs-restarting -r") %}

{% if result['retcode'] == 1 %}
{{ rule }} Check DNF pending restarts:
  test.fail_without_changes:
    - name: "{{ rule }} DNF updates is pending a reboot"
{% endif %}