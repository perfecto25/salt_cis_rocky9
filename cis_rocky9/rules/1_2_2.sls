# 1.2.2 - Ensure gpgcheck is globally activated

{% set rule = '(1.2.2)' %}
{{ rule }} ensure gpgcheck is globally activated - dnf.conf:
  ini.options_present:
    - name: /etc/dnf/dnf.conf
    - separator: '='
    - sections:
        main:
          gpgcheck: 1
