### NETWORK PARAMETERS HOST ONLY

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "3.2.1" in ignore %}
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
{% endif %} # "ignore"
#-----------------------------------------------------------------------


{% if not "3.2.2" in ignore %}
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

{% endif %} # "ignore"