###  MANDATORY ACCESS CONTROL
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.6.1.1" in ignore %}
{% set rule = '(1.6.1.1) Ensure SELinux is installed' %}
{{ rule }}:
  pkg.installed:
    - name: libselinux
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.2" in ignore %}
{% set rule = '(1.6.1.2) Ensure SELinux is not disabled in bootloader configuration' %}
{% set out = salt['cmd.run_all'](cmd="grubby --info=ALL | egrep '(selinux|enforcing)=0'", python_shell=True)["stdout"] %}
{{ rule }}:
{% if not out %}
  test.succeed_without_changes:
    - name: "{{ rule }} SELinux is enabled in bootloader"
{% else %}
  cmd.run:
    - name: grubby --update-kernel=ALL --remove-args "selinux=0 enforcing=0"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.3" in ignore %}
{% set rule = '(1.6.1.3) Ensure SELinux policy is configured' %}
{{ rule }}:
  file.line:
    - name: /etc/selinux/config
    - content: 'SELINUXTYPE=targeted'
    - match: "^SELINUXTYPE=.*"
    - mode: Replace
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.4" in ignore %}
{% set rule = '(1.6.1.4) Ensure the SELinux mode is not disabled ' %}
{{ rule }}:
  file.line:
    - name: /etc/selinux/config
    - content: 'SELINUX=enforcing'
    - match: "^SELINUX=.*"
    - mode: Replace
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.6" in ignore %}
{% set rule = '(1.6.1.6) Ensure no unconfined services exist' %}
{% set retval = salt['cmd.run_all'](cmd="ps -eZ | grep unconfined_service_t", python_shell=True)['stdout'] %}
{% if not retval %}
{{ rule }}:
  test.succeed_without_changes:
    - name: "{{ rule }} No unconfined daemons exist"
{% else %}
{{ rule }}:
  test.fail_without_changes:
    - name: "{{ rule }} unconfined daemons found: \n\n{{retval|replace('system_u', '\n') }} "
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.7" in ignore %}
{% set rule = '(1.6.1.7) Ensure SETroubleshoot is not installed ' %}
{{rule}}:
  pkg.removed:
    - name: setroubleshoot
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.8" in ignore %}
{% set rule = '(1.6.1.8) Ensure the MCS Translation Service (mcstrans) is not installed' %}
{{rule}}:
  pkg.removed:
    - name: mcstrans
{% endif %} # "ignore"