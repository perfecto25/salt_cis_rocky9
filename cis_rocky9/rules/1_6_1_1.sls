# 1.6.1.1 Ensure SELinux is installed

{% set rule = '(1.6.1.1)' %}

{{ rule }} Ensure SELinux is installed:
  pkg.installed:
    - name: libselinux