# 1.2.4 - Ensure repo_gpgcheck is globally activated

{% set rule = '(1.2.4)' %}
{% if grains.os != "RedHat" %}
# disabled for Redhat https://access.redhat.com/solutions/7019126
{{ rule }} ensure repo_gpgcheck is globally activated - dnf.conf:
  ini.options_present:
    - name: /etc/dnf/dnf.conf
    - separator: '='
    - sections:
        main:
          repo_gpgcheck: 1
{% endif %}
