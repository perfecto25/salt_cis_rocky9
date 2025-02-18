###  CONFIGURE HOST BASED FIREWALL
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "3.4.1.1" in ignore %}
{% set rule = '(3.4.1.1) Ensure nftables is installed' %}
{{ rule }}:
  pkg.installed:
    - name: nftables
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.4.1.2" in ignore %}
{% set rule = '(3.4.1.2) Ensure a single firewall configuration utility is in use' %}
{% set running = [] %}
{% for svc in ['iptables', 'nftables', 'firewalld'] %}
{% if salt['service.status'](svc) %}
{% do running.append(svc) %}
{% endif %}
{% endfor %}
{% if running|length > 1 %}
{{ rule }}:
  test.fail_without_changes:
    - name: "More than 1 firewall service is running: {{ running }}. Disable any unnecessary firewall services"
{% endif %}
{% endif %} # "ignore"
