{% set rule = '(3.3.5) Ensure broadcast ICMP requests are ignored' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.icmp_echo_ignore_broadcasts
    - value: 1

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.icmp_echo_ignore_broadcasts


