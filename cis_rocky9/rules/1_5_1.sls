{% set rule = '(1.5.1) Ensure core dump storage is disabled' %}

{{ rule }}:
  ini.options_present:
    - name: /etc/systemd/coredump.conf
    - separator: '='
    - sections:
        Coredump:
          Storage: "none"