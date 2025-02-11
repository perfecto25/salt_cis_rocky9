{% set rule = '(3.3.2) Ensure ICMP redirects are not accepted' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.conf.all.accept_redirects
    - value: 0

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv4.conf.default.accept_redirects
    - value: 0

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.conf.all.accept_redirects
      - sysctl: net.ipv4.conf.default.accept_redirects

