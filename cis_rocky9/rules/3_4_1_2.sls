{% set rule = '(3.4.1.2) Ensure a single firewall configuration utility is in use' %}

{% set running = [] %}

{% for svc in ['iptables', 'nftables', 'firewalld'] %}
{% if salt['service.status'](svc) %}
{% do running.append(svc) %}
{% do salt.log.error(running) -%}
{% endif %}
{% endfor %}


{% if running|length > 1 %}
{{ rule }}:
  test.fail_without_changes:
    - name: "More than 1 firewall service is running: {{ running }}. Disable any unnecessary firewall services"
{% endif %}


