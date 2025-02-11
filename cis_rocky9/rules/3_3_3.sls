{% set rule = '(3.3.3) Ensure secure ICMP redirects are not accepted' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.conf.all.secure_redirects
    - value: 0

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv4.conf.default.secure_redirects
    - value: 0

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.conf.all.secure_redirects
      - sysctl: net.ipv4.conf.default.secure_redirects

