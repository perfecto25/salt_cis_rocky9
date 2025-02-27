## USER ACCOUNTS config

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}


{% if not "5.6.1.1" in ignore %}
{% set rule = '(5.6.1.1) Ensure password expiration is 365 days or less' %}
{{ rule }}:
  file.replace:
    - name: /etc/login.defs
    - pattern: "^PASS_MAX_DAYS.*"
    - repl: PASS_MAX_DAYS {{ salt['pillar.get']('cis_rocky9:default:password:pass_max_days', '365') }} 
    - append_if_not_found: True
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.6.1.2" in ignore %}
{% set rule = '(5.6.1.2) Ensure minimum days between password changes is configured' %}
{{ rule }}:
  file.replace:
    - name: /etc/login.defs
    - pattern: "^PASS_MIN_DAYS.*"
    - repl: PASS_MIN_DAYS {{ salt['pillar.get']('cis_rocky9:default:password:pass_min_days', '1') }} 
    - append_if_not_found: True
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.6.1.3" in ignore %}
{% set rule = '(5.6.1.3) Ensure password expiration warning days is 7 or more' %}
{{ rule }}:
  file.replace:
    - name: /etc/login.defs
    - pattern: "^PASS_WARN_AGE.*"
    - repl: PASS_WARN_AGE {{ salt['pillar.get']('cis_rocky9:default:password:pass_warn_age', '7') }} 
    - append_if_not_found: True
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.6.1.4" in ignore %}
{% set rule = '(5.6.1.4) Ensure inactive password lock is 30 days or less' %}
{{ rule }}:
  cmd.run:
    - name: useradd -D -f {{ salt['pillar.get']('cis_rocky9:default:password:inactive_lock', '30') }} 
    - unless: useradd -D | grep INACTIVE={{ salt['pillar.get']('cis_rocky9:default:password:inactive_lock', '30') }} 
{% endif %} 

#-----------------------------------------------------------------------


{% if not "5.6.1.5" in ignore %}
{% set rule = '(5.6.1.5) Ensure all users last password change date is in the past' %}
{% set ret = salt['cmd.script']('salt://{}/files/5_6_1_5_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Users password change date is in the future: \n\n{{ ret['stdout'] }}"
{% endif %}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.6.2" in ignore %}
{% set rule = '5.6.2 Ensure system accounts are secured' %}
{% set ret = salt['cmd.script']('salt://{}/files/5_6_2_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{% for user in ret['stdout'].split() %}
{{ rule }} - {{ user }}:
  cmd.run:
    - name: usermod -s $(command -v nologin) {{user}} && usermod -L {{user}}
{% endfor %}
{% endif %}

{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.6.3" in ignore %}
{% set rule = '5.6.3 Ensure default user shell timeout is 900 seconds or less' %}
{{ rule }} - bashrc:
  file.replace:
    - name: /etc/bashrc
    - pattern: ^TMOUT=.*
    - repl: TMOUT={{ salt['pillar.get']('cis_rocky9:default:shell:timeout', 900) }}
    - append_if_not_found: True

{{ rule }} - profile:
  file.replace:
    - name: /etc/profile
    - pattern: ^TMOUT=.*
    - repl: TMOUT={{ salt['pillar.get']('cis_rocky9:default:shell:timeout', 900) }}
    - append_if_not_found: True
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.6.4" in ignore %}
{% set rule = '5.6.4 Ensure default user shell timeout is 900 seconds or less' %}
(5.4.3) Ensure default group for the root account is GID 0:
  user.present:
    - name: root
    - uid: 0
    - gid: 0
    - allow_gid_change: True
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.6.5" in ignore %}
{% set rule = '5.6.5 Ensure default user umask is 027 or more restrictive' %}


{{ rule }} - /etc/login.defs:
  file.replace:
    - name: /etc/login.defs
    - pattern: "^UMASK.*"
    - repl: UMASK  {{ salt['pillar.get']('cis_rocky9:default:umask:value', '027') }} 
    - append_if_not_found: True

{{ rule }} - /etc/bashrc:
  file.replace:
    - name: /etc/bashrc
    - pattern: "umask [0-9][0-9][0-9].*"
    - repl: "umask {{ salt['pillar.get']('cis_rocky9:default:umask:value', '027') }}" 
    - append_if_not_found: True

{% do salt.log.error(rule) -%}
{% endif %} 

#-----------------------------------------------------------------------

{% if not "5.6.6" in ignore %}
{% set rule = '5.6.6 Ensure root password is set' %}
{% set ret = salt['cmd.run_all'](cmd="passwd -S root | grep 'Password set'", python_shell=True)['stdout'] %}
{% if not ret %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Root account password is not set or is locked."
{% endif %}

{% endif %}

#-----------------------------------------------------------------------
