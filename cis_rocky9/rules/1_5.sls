### ADDITIONAL PROCESS HARDENING
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.5.1" in ignore %}
{% set rule = '(1.5.1) Ensure core dump storage is disabled' %}
{{ rule }}:
  ini.options_present:
    - name: /etc/systemd/coredump.conf
    - separator: '='
    - sections:
        Coredump:
          Storage: "none"
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.5.2" in ignore %}
{% set rule = '(1.5.2) Ensure core dump backtraces are disabled' %}

{{ rule }}:
  ini.options_present:
    - name: /etc/systemd/coredump.conf
    - separator: '='
    - sections:
        Coredump:
          ProcessSizeMax: 0
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.5.3" in ignore %}
{% set rule = '(1.5.3) Ensure address space layout randomization (ASLR) is enabled' %}

{{ rule }}:
  sysctl.present:
    - name: kernel.randomize_va_space
    - value: 2
{% endif %} # "ignore"