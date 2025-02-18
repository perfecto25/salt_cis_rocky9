###  MANDATORY ACCESS CONTROL
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "4.1.1.1" in ignore %}
{% set rule = '(4.1.1.1) Ensure audit is installed' %}
{{ rule }}:
  pkg.installed:
    - name: audit
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.1.2" in ignore %}
{% set rule = '(4.1.1.2) Ensure auditing for processes that start prior to auditd is enabled' %}
{{ rule }}:
  cmd.run:
    - name: grubby --update-kernel ALL --args 'audit=1'
    - unless: grubby --info=ALL | grep -Po '\baudit=1\b'
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.1.3" in ignore %}
{% set rule = '(4.1.1.3) Ensure audit_backlog_limit is sufficient' %}
{% set limit = salt['pillar.get']('cis_rocky9:default:auditd:backlog_limit', '8192') %}
{% set ret = salt['cmd.run_all'](cmd='grubby --info=ALL | grep -o "audit_backlog_limit=[0-9].*[0-9]" | cut -d"=" -f2', python_shell=True)['stdout'].split('\n') %}
{% set ns = namespace(flag=0) %}
{% if ret %}
## check if current limit settings for each kernel are below configured value
{% for ret in ret %}
  {% if ret|int < limit|int %}
    {% set ns.flag = 1 %}
  {% endif %}
{% endfor %}
  {% if ns.flag == 1 %}
{{ rule }}:
  cmd.run:
    - name: grubby --update-kernel ALL --args 'audit_backlog_limit={{ limit }}'
  {% endif %}
{% else %}
## no kernels have any config for limit, updating kernels with backlog limit
{{ rule }}:
  cmd.run:
    - name: grubby --update-kernel ALL --args 'audit_backlog_limit={{ limit }}'
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.1.4" in ignore %}
{% set rule = '(4.1.1.4) Ensure auditd service is enabled' %}
{{ rule }}:
  service.enabled:
    - name: auditd
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.2.1" in ignore %}
{% set rule = '(4.1.2.1) Ensure audit log storage size is configured' %}
{% if not salt['file.contains']('/etc/audit/auditd.conf', 'max_log_file') %}
{{ rule }}:
  test.fail_without_changes:
    - name: "/etc/audit/auditd.conf has no setting for: 'max_log_file'"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.2.2" in ignore %}
{% set rule = '(4.1.2.2) Ensure audit logs are not automatically deleted' %}
{{ rule }}:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: '^max_log_file_action = .*'
    - repl: "max_log_file_action = {{ salt['pillar.get']('cis_rocky9:default:auditd:max_log_file_action', 'keep_logs') }}"
    - append_if_not_found: True
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.2.3" in ignore %}
{% set rule = '(4.1.2.3) Ensure system is disabled when audit logs are full' %}
{{ rule }} - space_left_action:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: '^space_left_action = .*'
    - repl: 'space_left_action = {{ salt['pillar.get']('cis_rocky9:default:auditd:space_left_action', 'email') }}'
    - append_if_not_found: True

{{ rule }} - action_mail_acct:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: '^action_mail_acct = .*'
    - repl: "action_mail_acct = {{ salt['pillar.get']('cis_rocky9:default:action_mail_acct', 'root') }}"
    - append_if_not_found: True

{{ rule }} - Audit admin_space_left_action:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: '^admin_space_left_action = .*'
    - repl: "admin_space_left_action = {{ salt['pillar.get']('cis_rocky9:default:auditd:admin_space_left_action', 'halt') }}"
    - append_if_not_found: True
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.3" in ignore %}
{% set rule = '(4.1.3) Configure auditd rules' %}
{% set rules = {
  '4.1.3.1': '-w /etc/sudoers -p wa -k scope',
  '4.1.3.1': '-w /etc/sudoers.d/ -p wa -k scope',
  '4.1.3.2': '-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation',
  '4.1.3.2': '-a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k user_emulation',
  '4.1.3.3': '-w /var/log/sudo.log -p wa -k sudo_log_file',
  '4.1.3.4': '-a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -F key=time-change',
  '4.1.3.4': '-a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -F key=time-change',
  '4.1.3.4': '-w /etc/localtime -p wa -k time-change',
  '4.1.3.5': '-a always,exit -F arch=b64 -S sethostname,setdomainname -k system-locale',
  '4.1.3.5': '-a always,exit -F arch=b32 -S sethostname,setdomainname -k system-locale',
  '4.1.3.5': '-w /etc/issue -p wa -k system-locale',
  '4.1.3.5': '-w /etc/issue.net -p wa -k system-locale',
  '4.1.3.5': '-w /etc/hosts -p wa -k system-locale',
  '4.1.3.5': '-w /etc/sysconfig/network -p wa -k system-locale',
  '4.1.3.5': '-w /etc/sysconfig/network-scripts/ -p wa -k system-locale',
  '4.1.3.7': '-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -k access',
  '4.1.3.7': '-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -k access ',
  '4.1.3.7': '-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=unset -k access',
  '4.1.3.7': '-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=unset -k access',
  '4.1.3.8': '-w /etc/group -p wa -k identity',
  '4.1.3.8': '-w /etc/passwd -p wa -k identity',
  '4.1.3.8': '-w /etc/gshadow -p wa -k identity',
  '4.1.3.8': '-w /etc/shadow -p wa -k identity',
  '4.1.3.8': '-w /etc/security/opasswd -p wa -k identity',
  '4.1.3.9': '-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod',
  '4.1.3.9': '-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod',
  '4.1.3.9': '-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod',
  '4.1.3.9': '-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod',
  '4.1.3.9': '-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod',
  '4.1.3.9': '-a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod',
  '4.1.3.10': '-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -k mounts',
  '4.1.3.10': '-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=unset -k mounts',
  '4.1.3.11': '-w /var/run/utmp -p wa -k session',
  '4.1.3.11': '-w /var/log/wtmp -p wa -k session',
  '4.1.3.11': '-w /var/log/btmp -p wa -k session',
  '4.1.3.12': '-w /var/log/lastlog -p wa -k logins',
  '4.1.3.12': '-w /var/run/faillock -p wa -k logins',
  '4.1.3.13': '-a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat -F auid>=1000 -F auid!=unset -k delete',
  '4.1.3.13': '-a always,exit -F arch=b32 -S unlink,unlinkat,rename,renameat -F auid>=1000 -F auid!=unset -k delete',
  '4.1.3.14': '-w /etc/selinux -p wa -k MAC-policy',
  '4.1.3.14': '-w /usr/share/selinux -p wa -k MAC-policy',
  '4.1.3.15': '-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=unset -k perm_chng',
  '4.1.3.16': '-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=unset -k perm_chng',
  '4.1.3.17': '-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=unset -k perm_chng',
  '4.1.3.18': '-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=unset -k usermod',
  '4.1.3.19': '-a always,exit -F arch=b64 -S init_module,finit_module,delete_module,create_module,query_module -F auid>=1000 -F auid!=unset -k kernel_modules',
  '4.1.3.19': '-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=unset -k kernel_modules',
  '4.1.3.20': '-e 2'
}
%}

(4.1.3) cis_rocky9_audit_rules:
  file.managed:
    - name: /etc/audit/rules.d/cis_rocky9.rules
    - user: root
    - group: root
    - mode: "0640"
    - create: True
    - makedirs: True

{% for number, rule in rules.items() %}
{{ number }} - Audit rule "{{ rule }}":
  file.replace:
    - name: /etc/audit/rules.d/cis_rocky9.rules
    - pattern: '^{{ rule }}'
    - repl: '{{ rule }}'
    - append_if_not_found: True
{% endfor %}

auditd_service:
  cmd.wait:
    - name: service auditd restart

{% set rule = '(4.1.3.21) Ensure the running and on disk configuration is the same' %}
{{ rule }}:
  cmd.run:
    - name: augenrules --load
    - unless: augenrules --check | grep 'No change'
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.4.1" in ignore %}

{% set rule = '(4.1.4.1) Ensure audit log files are mode 0640 or less permissive' %}
{% set rcmd = '[ -f /etc/audit/auditd.conf ] && find "$(dirname $(awk -F "=" \'/^\s*log_file/ {print $2}\' /etc/audit/auditd.conf | xargs))" -type f \( ! -perm 600 -a ! -perm 0400 -a ! -perm 0200 -a ! -perm 0000 -a ! -perm 0640 -a ! -perm 0440 -a ! -perm 0040 \) -exec stat -Lc "%n" {} +'%}
{% set ret = salt['cmd.run_all'](cmd=rcmd, python_shell=True)['stdout'] %}
{{ rule }}:
  file.directory:
    - name: /var/log/audit
    - owner: root
    - group: root
    - mode: "0640"

{% if ret %}
{{ rule }} - {{ ret }}:
  file.managed:
    - name: {{ret}}
    - owner: root
    - group: root
    - mode: "0640"
{% endif %}

{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.4.3" in ignore %}
{% set rule = '(4.1.4.3) Ensure only authorized groups are assigned ownership of audit log files' %}
{{ rule }}:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: "^log_group.*"
    - repl: log_group = root
    - append_if_not_found: True 

{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.4.4" in ignore %}
{% set rule = '(4.1.4.4) Ensure audit configuration files are 640 or more restrictive' %}
{{ rule }}:
  file.directory:
    - name: /etc/audit
    - user: root
    - group: root
    - mode: "0640"
    - recurse:
      - user
      - group
      - mode
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.4.6" in ignore %}
{% set rule = '(4.1.4.6) Ensure audit configuration files are owned by root' %}
{% set ret = salt['cmd.run_all'](cmd="find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root", python_shell=True)['stdout'] %}
{% if ret %}
{% do salt.log.error(ret) -%}
{% for file in ret.split('\n') %}
{{ rule }} - {{ file }}:
  file.managed:
    - name: {{file}}
    - user: root
    - group: root
    - mode: "0640"
{% endfor %}
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.4.7" in ignore %}
{% set rule = '(4.1.4.7) Ensure audit configuration files belong to group root' %}
{% set ret = salt['cmd.run_all'](cmd="find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root", python_shell=True)['stdout'] %}
{% if ret %}
{% for file in ret.split('\n') %}
{{ rule }} - {{ file }}:
  file.managed:
    - name: {{file}}
    - user: root
    - group: root
    - mode: "0640"
{% endfor %}
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.1.4.8" in ignore %}
{% set rule = '(4.1.4.8) Ensure audit tools are 755 or more restrictive, owned by root' %}
{% for file in ['/sbin/auditctl', '/sbin/aureport', '/sbin/ausearch', '/sbin/autrace', '/sbin/auditd', '/sbin/augenrules'] %}
{{ rule }} - {{ file }}:
  file.managed:
    - name: {{ file }}
    - user: root
    - group: root
    - mode: 0700
{% endfor %}
{% endif %} # "ignore"
