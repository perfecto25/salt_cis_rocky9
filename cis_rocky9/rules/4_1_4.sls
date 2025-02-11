{% set rule = '(4.1.4) Ensure audit log files are mode 0640 or less permissive' %}

{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/4_1_4
    - cwd: /opt