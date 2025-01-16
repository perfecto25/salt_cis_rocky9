{% set rule = '(3.3.9) Ensure IPv6 router advertisements are not accepted' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv6.conf.all.accept_ra
    - value: 0

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv6.conf.default.accept_ra
    - value: 0

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv6.conf.all.accept_ra
      - sysctl: net.ipv6.conf.default.accept_ra


