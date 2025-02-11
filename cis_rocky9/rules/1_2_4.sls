{% set rule = '(1.2.4) Ensure repo_gpgcheck is globally activated' %}
{% if grains.os != "RedHat" %}
# disabled for Redhat https://access.redhat.com/solutions/7019126
{{ rule }}:
  ini.options_present:
    - name: /etc/dnf/dnf.conf
    - separator: '='
    - sections:
        main:
          repo_gpgcheck: 1
{% endif %}
