## SSHD config
 
{% set rule = '(5.2.1) Ensure permissions on /etc/ssh/sshd_config are configured' %}
{{ rule }} :
  file.managed:
    - name: /etc/ssh/sshd_config
    - mode: "0600"
    - user: root
    - group: root
    - replace: False 
 
{% set rule = '(5.2.2) Ensure permissions on SSH private host key files are configured' %}
{% set ret = salt['cmd.script']('salt://{}/files/5_2_2_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/5_2_2_rem
    - cwd: /opt
{% endif %}
 
{% set rule = '(5.2.3) Ensure permissions on SSH public host key files are configured' %}
{% set ret = salt['cmd.script']('salt://{}/files/5_2_3_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/5_2_3_rem
    - cwd: /opt
{% endif %}

{% set rule = '(5.2.5) Ensure SSH LogLevel is appropriate' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^LogLevel.*"
    - repl: LogLevel {{ salt['pillar.get']('cis_rocky9:default:sshd:log_level', 'INFO') }} 
    - append_if_not_found: True 
 
{% set rule = '(5.2.6) Ensure SSH PAM is enabled' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^UsePAM.*"
    - repl: UsePAM yes 
    - append_if_not_found: True 
 
{% set rule = '(5.2.7) Ensure SSH root login is disabled' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^PermitRootLogin.*"
    - repl: PermitRootLogin {{ salt['pillar.get']('cis_rocky9:default:sshd:permit_root_login', 'no') }} 
    - append_if_not_found: True 

{% set rule = '(5.2.8) Ensure HostbasedAuthentication is disabled' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^HostbasedAuthentication.*"
    - repl: HostbasedAuthentication {{ salt['pillar.get']('cis_rocky9:default:sshd:hostbased_authentication', 'no') }} 
    - append_if_not_found: True
 
{% set rule = '(5.2.9) Ensure PermitEmptyPasswords is disabled' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^PermitEmptyPasswords.*"
    - repl: PermitEmptyPasswords {{ salt['pillar.get']('cis_rocky9:default:sshd:permit_empty_passwords', 'no') }} 
    - append_if_not_found: True

{% set rule = '(5.2.10) Ensure PermitUserEnvironment is disabled' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^PermitUserEnvironment.*"
    - repl: PermitUserEnvironment {{ salt['pillar.get']('cis_rocky9:default:sshd:permit_user_environment', 'no') }} 
    - append_if_not_found: True

{% set rule = '(5.2.11) Ensure IgnoreRhosts is enabled' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^IgnoreRhosts.*"
    - repl: IgnoreRhosts {{ salt['pillar.get']('cis_rocky9:default:sshd:ignore_rhosts', 'yes') }} 
    - append_if_not_found: True

{% set rule = '(5.2.12) Ensure X11 forwarding is disabled' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^X11Forwarding.*"
    - repl: X11Forwarding {{ salt['pillar.get']('cis_rocky9:default:sshd:x11_forwarding', 'no') }} 
    - append_if_not_found: True
 
{% set rule = '(5.2.13) Ensure AllowTCPForwarding is disabled' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^AllowTcpForwarding.*"
    - repl: AllowTcpForwarding {{ salt['pillar.get']('cis_rocky9:default:sshd:allow_tcp_forwarding', 'no') }} 
    - append_if_not_found: True
 
{% set ret = salt['cmd.run_all']("grep -i '^\s*CRYPTO_POLICY=' /etc/sysconfig/sshd /etc/ssh/sshd_config.d/*.conf", python_shell=True) %}
{% if ret['stdout'] %}
(5.2.14) Ensure system-wide crypto policy is not over-ridden
  test.fail_without_changes:
    - name: Crypto ciphers are over-ridden {{ ret['stdout'] }}
{% endif %}

{% set rule = '(5.2.15) Ensure SSH warning banner is configured' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^Banner.*"
    - repl: Banner {{ salt['pillar.get']('cis_rocky9:default:sshd:banner', '/etc/issue.net') }} 
    - append_if_not_found: True

{% set rule = '(5.2.16) Ensure SSH MaxAuthTries is set to 4 or less' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^MaxAuthTries.*"
    - repl: MaxAuthTries {{ salt['pillar.get']('cis_rocky9:default:sshd:max_auth_tries', 3) }} 
    - append_if_not_found: True

{% set rule = '(5.2.17) Ensure SSH MaxStartups is configured' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^MaxStartups.*"
    - repl: MaxStartups {{ salt['pillar.get']('cis_rocky9:default:sshd:max_startups', '10:30:60') }} 
    - append_if_not_found: True

{% set rule = '(5.2.18) Ensure SSH MaxSessions is set to 10 or less' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^MaxSessions.*"
    - repl: MaxSessions {{ salt['pillar.get']('cis_rocky9:default:sshd:max_sessions', 10) }} 
    - append_if_not_found: True
 
{% set rule = '(5.2.19) Ensure SSH LoginGraceTime is set to 1 minute or less' %}
{{ rule }}:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^LoginGraceTime.*"
    - repl: LoginGraceTime {{ salt['pillar.get']('cis_rocky9:default:sshd:login_grace_time', 60) }} 
    - append_if_not_found: True

{% set rule = '(5.2.20) Ensure SSH Idle Timeout is configured' %}
{{ rule }} - client alive interval:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^ClientAliveInterval.*"
    - repl: ClientAliveInterval {{ salt['pillar.get']('cis_rocky9:default:sshd:client_alive_interval', 15) }} 
    - append_if_not_found: True

{{ rule }} - client alive count max:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: "^ClientAliveCountMax.*"
    - repl: ClientAliveCountMax {{ salt['pillar.get']('cis_rocky9:default:sshd:client_alive_count_max', 3) }} 
    - append_if_not_found: True