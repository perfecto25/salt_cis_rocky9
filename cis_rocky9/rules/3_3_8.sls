{% set rule = '(3.3.8) Ensure TCP SYN Cookies is enabled' %}

{{ rule }}:
  sysctl.present:
    - name: net.ipv4.tcp_syncookies
    - value: 1

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.tcp_syncookies
      


