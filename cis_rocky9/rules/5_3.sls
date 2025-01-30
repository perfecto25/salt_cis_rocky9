## SUDO config

{% if not '5.3.1' in salt["pillar.get"]("cis_rocky9:ignore:rules") %}  
{% set rule = '(5.3.1) Ensure sudo is installed' %}
{{ rule }} :
  pkg.installed:
    - name: sudo
{% endif %}  

{% if not '5.3.2' in salt["pillar.get"]("cis_rocky9:ignore:rules") %}  
{% set rule = '(5.3.2) Ensure sudo commands use pty' %}
{{ rule }}:
  file.replace:
    - name: /etc/sudoers
    - pattern: "^Defaults.*use_pty"
    - repl: Defaults use_pty 
    - append_if_not_found: True 
{% endif %}

{% if not '5.3.3' in salt["pillar.get"]("cis_rocky9:ignore:rules") %}  
{% set rule = '(5.3.3) Ensure sudo log file exists' %}
{{ rule }}:
  file.replace:
    - name: /etc/sudoers
    - pattern: "^Defaults.*logfile"
    - repl: Defaults logfile="{{ salt['pillar.get']('cis_rocky9:default:sudo:log_file', '/var/log/sudo.log') }}" 
    - append_if_not_found: True 
{% endif %}
