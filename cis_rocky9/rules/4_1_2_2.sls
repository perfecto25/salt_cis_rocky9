{% set rule = '(4.1.2.2) Ensure audit logs are not automatically deleted' %}

{{ rule }}:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: '^max_log_file_action = .*'
    - repl: "max_log_file_action = {{ salt['pillar.get']('cis_rocky9:default:auditd:max_log_file_action', 'keep_logs') }}"
    - append_if_not_found: True
