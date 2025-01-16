{% set rule = '(3.3.7) Ensure Reverse Path Filtering is enabled' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.conf.all.rp_filter
    - value: 1

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv4.conf.default.rp_filter
    - value: 1

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.conf.all.rp_filter
      - sysctl: net.ipv4.conf.default.rp_filter


