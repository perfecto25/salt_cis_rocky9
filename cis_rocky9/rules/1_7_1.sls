# 1.7.1  Ensure message of the day is configured properly

{% set rule = '(1.7.1)' %}


{% set flags = ['\\v', '\m', '\s', '\\r', 'os-release'] %}
{% for flag in flags %}
{% if salt['file.contains']("/etc/motd", flag) %}
{{ rule }} Ensure /etc/motd is configured correctly ({{ flag }}):
  test.fail_without_changes:
    - name: "{{ rule }} /etc/motd contains OS release information"
{% endif %}
{% endfor %}