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

/etc/audit/rules.d/audit.rules:
  cmd.run:
    - name: touch /etc/audit/rules.d/cis_rocky9.rules
    - unless: test -f /etc/audit/rules.d/cis_rocky9.rules

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