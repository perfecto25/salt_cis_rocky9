{% set rule = '(4.1.1.4) Ensure auditd service is enabled' %}

{{ rule }}:
  service.enabled:
    - name: auditd


