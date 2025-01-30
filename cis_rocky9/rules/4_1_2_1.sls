{% set rule = '(4.1.2.1) Ensure audit log storage size is configured' %}

{% if not salt['file.contains']('/etc/audit/auditd.conf', 'max_log_file') %}
{{ rule }}:
  test.fail_without_changes:
    - name: "/etc/audit/auditd.conf has no setting for: 'max_log_file'"
{% endif %}

