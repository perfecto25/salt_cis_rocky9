{% set rule = '(3.3.4) Ensure suspicious packets are logged' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.conf.all.log_martians
    - value: 0

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv4.conf.default.log_martians
    - value: 0

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.conf.all.log_martians
      - sysctl: net.ipv4.conf.default.log_martians

