# 1.5.1 Ensure core dump storage is disabled

{% set rule = '(1.5.1)' %}

{{ rule }} Disable core dumps:
  ini.options_present:
    - name: /etc/systemd/coredump.conf
    - separator: '='
    - sections:
        Coredump:
          Storage: "none"