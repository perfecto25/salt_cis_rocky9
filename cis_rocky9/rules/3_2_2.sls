{% set rule = '(3.2.2) Ensure packet redirect sending is disabled' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.conf.all.send_redirects
    - value: 0

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv4.conf.default.send_redirects
    - value: 0

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.conf.all.send_redirects
      - sysctl: net.ipv4.conf.default.send_redirects

