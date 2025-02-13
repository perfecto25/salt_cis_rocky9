## USER ACCOUNTS config

{% set rule = '(5.6.1.1) Ensure password expiration is 365 days or less' %}
{{ rule }}:
  file.replace:
    - name: /etc/login.defs
    - pattern: "^PASS_MAX_DAYS.*"
    - repl: PASS_MAX_DAYS {{ salt['pillar.get']('cis_rocky9:default:password:pass_max_days', '365') }} 
    - append_if_not_found: True

{% set rule = '(5.6.1.2) Ensure minimum days between password changes is configured' %}
{{ rule }}:
  file.replace:
    - name: /etc/login.defs
    - pattern: "^PASS_MIN_DAYS.*"
    - repl: PASS_MIN_DAYS {{ salt['pillar.get']('cis_rocky9:default:password:pass_min_days', '1') }} 
    - append_if_not_found: True

{% set rule = '(5.6.1.3) Ensure password expiration warning days is 7 or more' %}
{{ rule }}:
  file.replace:
    - name: /etc/login.defs
    - pattern: "^PASS_WARN_AGE.*"
    - repl: PASS_WARN_AGE {{ salt['pillar.get']('cis_rocky9:default:password:pass_warn_age', '7') }} 
    - append_if_not_found: True

{% set rule = '(5.6.1.4) Ensure inactive password lock is 30 days or less' %}
{{ rule }}:
  cmd.run:
    - name: useradd -D -f {{ salt['pillar.get']('cis_rocky9:default:password:inactive_lock', '30') }} 
    - unless: useradd -D | grep INACTIVE={{ salt['pillar.get']('cis_rocky9:default:password:inactive_lock', '30') }} 


{% set rule = '(5.6.1.5) Ensure all users last password change date is in the past' %}
{% set retval = salt['cmd.script']('salt://{}/files/5_6_1_5_audit'.format(slspath), cwd='/opt') %}
{% do salt.log.error(retval['stdout']) -%}
{% if retval['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Users password change date is in the future: \n\n{{ retval['stdout'] }}"
{% endif %}


{% set rule = '5.6.2 Ensure system accounts are secured' %}
{% set retval = salt['cmd.script']('salt://{}/files/5_6_2_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] %}
{% for user in retval['stdout'].split() %}
{{ rule }} - {{ user }}:
  cmd.run:
    - name: usermod -s $(command -v nologin) {{user}} && usermod -L {{user}}
{% endfor %}
{% endif %}

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

{% set rule = '5.6.4 Ensure default user shell timeout is 900 seconds or less' %}
(5.4.3) Ensure default group for the root account is GID 0:
  user.present:
    - name: root
    - uid: 0
    - gid: 0
    - allow_gid_change: True
{% do salt.log.error(retval['stdout'].split()) -%}