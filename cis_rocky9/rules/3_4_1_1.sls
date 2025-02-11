{% set rule = '(3.4.1.1) Ensure nftables is installed' %}

{{ rule }}:
  pkg.installed:
    - name: nftables


