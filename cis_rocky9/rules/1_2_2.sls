{% set rule = '(1.2.2) Ensure gpgcheck is globally activated' %}
{{ rule }}:
  ini.options_present:
    - name: /etc/dnf/dnf.conf
    - separator: '='
    - sections:
        main:
          gpgcheck: 1
