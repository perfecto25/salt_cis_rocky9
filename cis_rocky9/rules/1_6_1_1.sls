{% set rule = '(1.6.1.1) Ensure SELinux is installed' %}

{{ rule }}:
  pkg.installed:
    - name: libselinux