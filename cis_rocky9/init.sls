## Global Rules (can override via host-specific pillar, see sample.pillar.sls)

{% set rules = {
    '1.1.1': {'Disable unused filesystems': True },
    '1.1.2.1': {'Ensure separate partition exists for /tmp': True },
    '1.1.2.2': {'Ensure nodev, nosuid, noexec option set on /tmp partition':            True}, 
    '1.1.3.1': {'Ensure separate partition exists for /var':                            True},  
    '1.1.3.2': {'Ensure nodev, nosuid, noexec option set on /var partition':            True},
    '1.1.4.1': {'Ensure separate partition exists for /var/tmp':                        True},
    '1.1.4.2': {'Ensure nodev, nosuid, noexec option set on /var/tmp partition':       True },
    '1.1.5.1': {'Ensure separate partition exists for /var/log':                       True },
    '1.1.5.2': {'Ensure nodev, nosuid, noexec option set on /var/log partition':       True },
    '1.1.6.1': {'Ensure separate partition exists for /var/log/audit':                 True },
    '1.1.6.2': {'Ensure nodev, nosuid, noexec option set on /var/log/audit partition': True },
    '1.1.7.1': {'Ensure separate partition exists from /home':                         True },
    '1.1.7.2': {'Ensure nodev set on /home':                                           True },
    '1.1.7.3': {'Ensure nosuid set on /home':                                          True },
    '1.1.8.1': {'Ensure /dev/shm is a separate partition':                             True },
    '1.1.8.2': {'Ensure nodev, nosuid, noexec option set on /dev/shm partition':       True },
    '1.1.9': {'Disable USB storage':                                                 True },
    '1.2.1': {'Ensure GPG keys are configured':                                      True },
    '1.2.2':  { 'Ensure gpgcheck is globally activated':                  True },
    '1.2.3': {'Ensure package manager repositories are configured':     True },
    '1.2.4': { 'Ensure repo_gpgcheck is globally activated':      True },
    '1.3.1':     { 'AIDE configuration':                                                  True },
    '1.3.2': {'Ensure filesystem integrity is regularly checked': True}
    '1.3.3': {'Ensure cryptographic mechanisms are used to protect the integrity of audity tools': True},
    '1.4.1':   { 'Ensure bootloader password is set':                                   True },
    '1.4.2':   { 'Ensure permissions on bootloader config are configured':              True },
    '1.5.1': { 'Ensure core dump storage is disabled':  True},
    '1.5.2': { 'Ensure core dump backtraces are disabled': True},
    '1.5.3': { 'Ensure address space layout randomization (ASLR) is enabled': True}
    '1.6.1.1': { 'Ensure SELinux is installed':                                        True },
    '1.6.1.2': { 'Ensure SELinux not disabled in bootloader configuration': True},
    '1.6.1.3': { 'Ensure SELinux policy is configured': True},
    '1.6.1.4': { 'Ensure SELinux mode is not disabled': True },
    '1.6.1.5': { 'Ensure SELinux mode is enforcing': True},
    '1.6.1.6': { 'Ensure no unconfined services exist':                                 True },
    '1.6.1.7': { 'Ensure SETroubleshoot is not installed':                              True },
    '1.6.1.8': { 'Ensure the MCS Translation Service (mcstrans) is not installed':      True },
    '1.7.1':   { 'Ensure motd, banners are configured':                                 True }, # 1.7.1 - 1.7.6
    '1.8.1':  { 'Ensure GNOME display manager is removed': True},
    '1.8.2':   { 'Ensure GDM login banner is configured':                               True },
    '1.8.3': { 'Ensure GDM disable-user-list option is enabled': True},
    '1.8.4': { 'Ensure GDM screen locks when user is idle': True},
    '1.8.5': { 'Ensure GDM screen locks cannot be overridden': True},
    '1.8.6': { 'Ensure GDM automatic mounting of removable media is disabled': True },
    '1.8.7': { 'Ensure GDM disabling automatic mounting of removable media is not overriden': True},
    '1.8.8': { 'Ensure GDM autorun-never is enabled': True},
    '1.8.9': { 'Ensure GDM autorun-never is not overriden': True},
    '1.8.10': { 'Ensure XDCMP is not enabled': True},
    '1.9': { 'Ensure updates, patches and additional security software are installed': True},
    '1.10': {'Ensure system-wide crypto policy is not legacy': True}
    '2.1.1': { 'Ensure time synchronization is in use':                               True },
    '2.1.2': {'Ensure chrony is configured': True},
    '2.2':     { 'Ensure unnecessary packages are not installed, services disabled':    True }, # 2.2.1 - 2.2.14, 2.2.16 - 2.2.18
    '2.2.15':  { 'Ensure mail transfer agent is configured for local-only mode':        True },
    '2.3':     { 'Ensure service clients are not installed':                            True }, # 2.3.1 - 2.3.4
    '2.4': {'Ensure nonessential services listen on system are removed or masked': True },
    '3.1.1':     { 'IPv6 configuration':                                                  True },
    '3.1.2': {'Ensure wireless interfaces are disabled':  True},
    '3.1.3': { 'Ensure TIPC is disabled': True},
    '3.2.1': { 'Ensure IP forwarding is disabled': True}.
    '3.2.2': {'Ensure packet redirect sending is disabled': True},
    '3.3.1': {'Ensure source routed packets are not accepted': True}
    '3.3.2': {'Ensure ICMP redirects are not accepted': True},
    '3.3.3': { 'Ensure secure ICMP redirects are not accepted': True},
    '3.3.4': {'Ensure suspicious packets are logged': True},


    '1.1.21':  { 'Ensure sticky bit is set on all world writeable directories':         True },
    '1.1.22':  { 'Disable automounting':                                                True },
    '1.4.3':   { 'Ensure authentication required for single user mode':                 True },
    '1.5.1':   { 'Ensure core dumps are restricted':                                    True },
    '1.5.2':   { 'Ensure XD/NX support is enabled':                                     True },
    '1.5.3':   { 'Ensure address space layout randomization (ASLR) is enabled':         True },
    '1.5.4':   { 'Ensure prelink is disabled':                                          True },
    
    
    
    
    
   
    '3.2':     { 'Network parameters for host and router systems':                      True },
    
    '3.4':     { 'Ensure TCP Wrappers are installed':                                   True },
    '3.5':     { 'Uncommon network protocols':                                          True },
    '4.1.1':   { 'Configure system accounting':                                         True },
    '4.1.2':   { 'Ensure auditd service is enabled':                                    True },
    '4.1.3':   { 'Ensure auditing for processes that start prior to auditd is enabled': True },
    '4.1.4':   { 'Ensure audit rules are in place':                                     True },
    '4.2.1':   { 'Configure Rsyslog':                                                   True },
    '4.2.4':   { 'Ensure proper permissions on log files':                              True },
    '5.1':     { 'Ensure proper cron file permissions':                                 True },
    '5.2':     { 'Ensure SSH service is configured':                                    True },
    '5.3.1':   { 'Ensure password creation requirements are in place':                  True },
    '5.3.2':   { 'Ensure lockout for failed password attempts is configured':           True },
    '5.3.3':   { 'Ensure password reuse is limited':                                    True },
    '5.3.4':   { 'Ensure password hashing algorith is SHA-512':                         True },
    '5.4.1':   { 'Password complexity configuration':                                   True },
    '5.4.2':   { 'Ensure system accounts are non-login':                                True },
    '5.4.3':   { 'Ensure default group for the root account is GID 0':                  True },
    '5.4.4':   { 'Ensure default user umask is 027 or more restrictive':                True },
    '5.4.5':   { 'Ensure default user shell timeout is 900 seconds or less':            True },
    '5.6':     { 'Ensure access to the su command is restricted':                       True },
    '6.1.2':   { 'Ensure system file permissions':                                      True },
    '6.1.10':  { 'Ensure no world writeable files exist':                               True },
    '6.1.11':  { 'Ensure no unowned files or directories exist':                        True },
    '6.1.12':  { 'Ensure no ungrouped files or directories exist':                      True },
    '6.1.13':  { 'Audit SUID executables':                                              True },
    '6.1.14':  { 'Audit SGID executables':                                              True },
    '6.2.1':   { 'Ensure password fields are not empty':                                True },
    '6.2.2':   { 'Ensure no legacy "+" entries exist in /etc/passwd':                   True },
    '6.2.3':   { 'Ensure no legacy "+" entries exist in /etc/shadow':                   True },
    '6.2.4':   { 'Ensure no legacy "+" entries exist in /etc/group':                    True },
    '6.2.5':   { 'Ensure root is the only UID 0 account':                               True },
    '6.2.6':   { 'Ensure root PATH integrity':                                          True },
    '6.2.7':   { 'Ensure all users home directories exist':                             True },
    '6.2.8':   { 'Ensure users home directories permissions are 750':                   True },
    '6.2.9':   { 'Ensure users own their home directories':                             True },
    '6.2.10':  { 'Ensure users dot files are not group or world writable':              True },
    '6.2.11':  { 'Ensure no users have .forward files':                                 True },
    '6.2.12':  { 'Ensure no users have .netrc files':                                   True },
    '6.2.13':  { 'Ensure users .netrc Files are not group or world accessible':         True },
    '6.2.14':  { 'Ensure no users have .rhosts files ':                                 True },
    '6.2.15':  { 'Ensure all groups in /etc/passwd exist in /etc/group':                True },
    '6.2.16':  { 'Ensure no duplicate UIDs exist':                                      True },
    '6.2.17':  { 'Ensure no duplicate GIDs exist':                                      True },
    '6.2.18':  { 'Ensure no duplicate user names exist':                                True },
    '6.2.19':  { 'Ensure no duplicate group names exist':                               True }
} %}

{% if grains['osfinger'] == 'CentOS Linux-7' %}

include:
{% for rule in rules %}
{% for desc, check in rules[rule].items() %}
{% if check %}

{% if rules[rule] %}
    {% if not rule in salt['pillar.get']('cis:ignore:rules') %}
    - cis.rules.{{ rule|replace('.', '_') }}
    {% endif %}
{% endif %}

{% endif %}
{% endfor %}
{% endfor %}

{% endif %}