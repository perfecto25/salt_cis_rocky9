{% set rule = '(3.3.1) Ensure source routed packets are not accepted' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.conf.all.accept_source_route
    - value: 0

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv4.conf.default.accept_source_route
    - value: 0

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.conf.all.accept_source_route
      - sysctl: net.ipv4.conf.default.accept_source_route

