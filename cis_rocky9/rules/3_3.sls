###  NETWORK PARAMETERS HOST AND ROUTER

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "3.3.1" in ignore %}

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
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.3.2" in ignore %}
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
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.3.3" in ignore %}
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
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.3.4" in ignore %}
{% set rule = '(3.3.4) Ensure suspicious packets are logged' %}

{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.conf.all.log_martians
    - value: 0

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv4.conf.default.log_martians
    - value: 0

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.conf.all.log_martians
      - sysctl: net.ipv4.conf.default.log_martians
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.3.5" in ignore %}
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
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.3.6" in ignore %}
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
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.3.7" in ignore %}
{% set rule = '(3.3.7) Ensure Reverse Path Filtering is enabled' %}
{{ rule }} - (all):
  sysctl.present:
    - name: net.ipv4.conf.all.rp_filter
    - value: 1

{{ rule }} - (default):
  sysctl.present:
    - name: net.ipv4.conf.default.rp_filter
    - value: 1

{{ rule }} - (flush):
  sysctl.present:
    - name: net.ipv4.route.flush
    - value: 1
    - onchanges:
      - sysctl: net.ipv4.conf.all.rp_filter
      - sysctl: net.ipv4.conf.default.rp_filter
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.3.8" in ignore %}
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
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.3.9" in ignore %}
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
{% endif %} # "ignore"