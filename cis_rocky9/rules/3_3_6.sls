{% set rule = '(3.3.6) Ensure bogus ICMP responses are ignored' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.icmp_ignore_bogus_error_responses
    - value: 1

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.icmp_ignore_bogus_error_responses


