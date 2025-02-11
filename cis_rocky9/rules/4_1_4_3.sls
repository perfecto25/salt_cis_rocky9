{% set rule = '(4.1.4.3) Ensure only authorized groups are assigned ownership of audit log files' %}

{{ rule }}:
  file.directory:
    - name: /var/log/audit
    - owner: root
    - group: root
    - mode: 0750
    - recurse:
      - user
      - group
      - mode