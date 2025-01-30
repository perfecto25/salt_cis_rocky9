{% set rule = '(4.1.1.2) Ensure auditing for processes that start prior to auditd is enabled' %}

{{ rule }}:
  cmd.run:
    - name: grubby --update-kernel ALL --args 'audit=1'
    - unless: grubby --info=ALL | grep -Po '\baudit=1\b'


