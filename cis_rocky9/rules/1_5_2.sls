{% set rule = '(1.5.2) Ensure core dump backtraces are disabled' %}

{{ rule }}:
  ini.options_present:
    - name: /etc/systemd/coredump.conf
    - separator: '='
    - sections:
        Coredump:
          ProcessSizeMax: 0