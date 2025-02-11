{% set rule = '(1.6.1.4) Ensure the SELinux mode is not disabled ' %}

{{ rule }}:
  file.line:
    - name: /etc/selinux/config
    - content: 'SELINUX=enforcing'
    - match: "^SELINUX=.*"
    - mode: Replace