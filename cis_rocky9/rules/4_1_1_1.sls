{% set rule = '(4.1.1.1) Ensure audit is installed' %}

{{ rule }}:
  pkg.installed:
    - name: nftables


