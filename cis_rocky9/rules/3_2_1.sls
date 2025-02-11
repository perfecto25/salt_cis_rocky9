{% set rule = '(3.2.1) Ensure IP forwarding is disabled' %}

{{ rule }}:
  sysctl.present:
    - name: net.ipv4.ip_forward
    - value: 0

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.ip_forward

