# 1.6.1.3 Ensure SELinux policy is configured

{% set rule = '(1.6.1.3)' %}

{{ rule }} SELinux type is targeted:
  file.line:
    - name: /etc/selinux/config
    - content: 'SELINUXTYPE=targeted'
    - match: "^SELINUXTYPE=.*"
    - mode: Replace