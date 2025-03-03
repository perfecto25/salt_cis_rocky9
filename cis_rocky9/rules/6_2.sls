## Local User and Group setings

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}


{% if not "6.2.1" in ignore %}
{% set rule = '(6.2.1) Ensure accounts in /etc/passwd use shadowed passwords' %}
{% set ret = salt['cmd.run_all'](cmd='awk -F: \'($2 != "x" ) {print $1}\' /etc/passwd', python_shell=True)['stdout'] %}
{% if ret %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/6_2_1_rem
    - cwd: /opt
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "6.2.2" in ignore %}
{% set rule = '(6.2.2) Ensure /etc/shadow password fields are not empty' %}
{% set ret = salt['cmd.run_all'](cmd='awk -F: \'($2 == "" ) { print $1}\' /etc/shadow', python_shell=True)['stdout'] %}
{% if ret %}
{% for user in ret.split('\n') %}
{{ rule }} - {{user}}:
  cmd.run:
    - name: passwd -l {{user}}
{% endfor %}
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "6.2.3" in ignore %}
{% set rule = '(6.2.3) Ensure all groups in /etc/passwd exist in /etc/group' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_3_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "\n\n{{ ret['stdout'] }}\n\n"
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "6.2.4" in ignore %}
{% set rule = '(6.2.4) Ensure no duplicate UIDs exist' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_4_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "\n\n{{ ret['stdout'] }}\n\n"
{% endif %}
{% endif %}

#-----------------------------------------------------------------------

{% if not "6.2.5" in ignore %}
{% set rule = '(6.2.5) Ensure no duplicate GIDs exist' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_5_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "\n\n{{ ret['stdout'] }}\n\n"
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "6.2.6" in ignore %}
{% set rule = '(6.2.6) Ensure no duplicate user names exist' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_6_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "\n\n{{ ret['stdout'] }}\n\n"
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "6.2.7" in ignore %}
{% set rule = '(6.2.7) Ensure no duplicate group names exist' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_7_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "\n\n{{ ret['stdout'] }}\n\n"
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "6.2.8" in ignore %}
{% set rule = '(6.2.8) Ensure root PATH integrity' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_8_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "\n\n{{ ret['stdout'] }}\n\n"
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "6.2.9" in ignore %}
{% set rule = '(6.2.9) Ensure root is the only UID 0 account' %}
{% set ret = salt['cmd.run_all'](cmd="awk -F: '($3 == 0) { print $1 }' /etc/passwd", python_shell=True) %}
{% if ret['stdout'] != "root" %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Other accounts besides root have UID=0:\n\n{% for user in ret['stdout'].split('\n') %} - {{ user }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.2.10" in ignore %}
{% set rule = '(6.2.10)  Ensure local interactive user home directories exist' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_10_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{rule}}:
  cmd.script:
    - source: salt://{{ slspath }}/files/6_2_10_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.2.11" in ignore %}
{% set rule = '(6.2.11) Ensure local interactive users own their home directories' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_11_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{rule}}:
  cmd.script:
    - source: salt://{{ slspath }}/files/6_2_11_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.2.12" in ignore %}
{% set rule = '(6.2.12) Ensure local interactive user home directories are mode 750 or more restrictive' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_12_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{rule}}:
  cmd.script:
    - source: salt://{{ slspath }}/files/6_2_12_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.2.13" in ignore %}
{% set rule = '(6.2.13)  Ensure no local interactive user has .netrc files' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_13_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{rule}}:
  cmd.script:
    - source: salt://{{ slspath }}/files/6_2_13_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.2.14" in ignore %}
{% set rule = '(6.2.14)  Ensure no local interactive user has .forward files' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_14_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{rule}}:
  cmd.script:
    - source: salt://{{ slspath }}/files/6_2_14_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.2.15" in ignore %}
{% set rule = '(6.2.15)  Ensure no local interactive user has .rhosts files' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_15_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{rule}}:
  cmd.script:
    - source: salt://{{ slspath }}/files/6_2_15_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.2.16" in ignore %}
{% set rule = '(6.2.16) Ensure local interactive user dot files are not group or world writable' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_2_16_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{rule}}:
  cmd.script:
    - source: salt://{{ slspath }}/files/6_2_16_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"