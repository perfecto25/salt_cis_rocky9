## SUDO config

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "5.3.1" in ignore %}
{% set rule = '(5.3.1) Ensure sudo is installed' %}
{{ rule }}:
  pkg.installed:
    - name: sudo
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.3.2" in ignore %}
{% set rule = '(5.3.2) sudoers file restrictions' %}
{{ rule }}:
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

#-----------------------------------------------------------------------

{% if not "5.3.4" in ignore %}
{% set rule = '(5.3.4) Ensure users provide password for escalation' %}
{% set ret = salt['cmd.run_all']('grep -r "^[^#].*NOPASSWD" /etc/sudoers.d/*', python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "/etc/sudoers.d/* contains NOPASSWD escalation: \n\n{{ ret['stdout']|replace('/etc/sudoers.d', '\n/etc/sudoers.d') }}"
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.3.5" in ignore %}
{% set rule = '(5.3.5) Ensure re-authentication for privilege escalation is not disabled globally' %}
{% set ret = salt['cmd.run_all']('grep -r "^[^#].*\!authenticate" /etc/sudoers*', python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "/etc/sudoers* has re-authentication for privilege escalation disabled: \n\n{{ ret['stdout']|replace('/etc/sudoers', '\n/etc/sudoers') }}"
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.3.7" in ignore %}
{% set rule = '(5.3.7) Ensure access to the su command is restricted' %}
{{ rule }} - sugroup:
  group.present:
    - name: {{ pillar.get('cis_rocky9:default:sudo:su_group', 'sugroup') }}
    - gid: {{ pillar.get('cis_rocky9:default:sudo:su_group_gid', 8501) }}

{{ rule }}:
  file.managed:
    - name: /etc/pam.d/su
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - source: salt://{{ slspath }}/files/5_3_su.j2
    - template: jinja
{% endif %}
