{% set rule = '(4.1.4.5) Ensure audit configuration files are 640 or more restrictive' %}

{{ rule }}:
  file.directory:
    - name: /etc/audit
    - owner: root
    - group: root
    - mode: 0640
    - recurse:
      - user
      - group
      - mode