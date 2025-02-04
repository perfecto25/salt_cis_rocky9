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
    - pattern: "^Defaults.*logfile=.*"
    - repl: Defaults logfile="{{ salt['pillar.get']('cis_rocky9:default:sudo:log_file', '/var/log/sudo.log') }}" 
    - append_if_not_found: True 
{% endif %}

{% if not '5.3.4' in salt["pillar.get"]("cis_rocky9:ignore:rules") %}  
{% set rule = '(5.3.4) Ensure users provide password for escalation' %}
{% set retval = salt['cmd.run_all']('grep -r "^[^#].*NOPASSWD" /etc/sudoers.d/*', python_shell=True) %}
{% if retval['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "/etc/sudoers.d/* contains NOPASSWD escalation"
{% endif %}
{% endif %}

{% if not '5.3.5' in salt["pillar.get"]("cis_rocky9:ignore:rules") %}  
{% set rule = '(5.3.5) Ensure re-authentication for privilege escalation is not disabled globally' %}
{% set retval = salt['cmd.run_all']('grep -r "^[^#].*\!authenticate" /etc/sudoers*', python_shell=True) %}
{% if retval['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "/etc/sudoers* has re-authentication for privilege escalation disabled"
{% endif %}
{% endif %}

{% if not '5.3.6' in salt["pillar.get"]("cis_rocky9:ignore:rules") %}  
{% set rule = '(5.3.6) Ensure sudo authentication timeout is configured correctly' %}
{% set retval = salt['cmd.run_all']('grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers* | awk -F \':\' {\'print $2\'}', python_shell=True) %}
{% if retval['stdout'] is defined and retval['stdout']|int > 5 %}
{{ rule }}:
  file.replace:
    - name: /etc/sudoers
    - pattern: "^Defaults.*timestamp_timeout=.*"
    - repl: Defaults timestamp_timeout="{{ salt['pillar.get']('cis_rocky9:default:sudo:timeout', '5') }}" 
    - append_if_not_found: True 
    - check_cmd:
       - /usr/sbin/visudo -cf /etc/sudoers
{% endif %}
{% endif %}


{% if not '5.3.7' in salt["pillar.get"]("cis_rocky9:ignore:rules") %}  
{% set rule = '(5.3.7) Ensure access to the su command is restricted' %}
{% set retval = salt['cmd.run_all']("grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su", python_shell=True) %}
{% if retval['stdout'] is defined and not 'group=' in retval['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "/etc/sudoers* does not restrict su command to a group, ie 'auth required pam_wheel.so use_uid group=<group_name>': ({{ retval['stdout'] }} min)"
{% endif %}
{% endif %}

{% if not '5.3' in salt["pillar.get"]("cis_rocky9:ignore:rules") %}  
{% set rule = '(5.3) sudoers file restrictions' %}
{{ rule }}
  file.managed:
    - name: /etc/sudoers
    - user: root
    - group: root
    - mode: "0440"
    - create: False
    - source: salt://{{ slspath }}/files/5_3_sudoers.j2
    - template: jinja
    - check_cmd: /usr/sbin/visudo -c -f /etc/sudoers
{% endif %}