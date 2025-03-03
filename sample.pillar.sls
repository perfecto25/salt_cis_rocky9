# Sample Pillar showing all possible values that can be configured for CIS compliance

cis_rocky9:
  ignore:
    rules: # ignore these rules
      - 1.1.1       # disable unused file systems
      - 1.1.2       # configure /tmp
      - 1.1.3       # configure /var
      - 1.1.4       # configure /var/tmp
      - 1.1.5       # configure /var/log
      - 1.1.6       # configure /var/log/audit
      - 1.1.7       # configure /home
      - 1.1.8       # configure /dev/shm
      - 1.2.1       # configure gpg keys
      - 1.2.2       # ensure gpgcheck is globally activated
      - 1.2.4       # ensure repo_gpgcheck is globally activated
      - 1.3.1       # ensure AIDE is installed
      - 1.3.2       # Ensure filesystem integrity is regularly checked
      - 1.3.3       # Ensure cryptographic mechanisms are used to protect the integrity of audit tools
      - 1.4.1       # Ensure bootloader password is set
      - 1.4.2       # Ensure permissions on bootloader config are configured
      - 1.5.1       # Ensure core dump storage is disabled
      - 1.5.2       # Ensure core dump backtraces are disabled
      - 1.5.3       # Ensure address space layout randomization ASLR is enabled
      - 1.6.1.1     # Ensure SELinux is installed
      - 1.6.1.2     # Ensure SELinux is not disabled in bootloader configuration
      - 1.6.1.3     # Ensure SELinux policy is configured
      - 1.6.1.4     # Ensure the SELinux mode is not disabled
      - 1.6.1.6     # Ensure no unconfined services exist
      - 1.6.1.7     # Ensure SETroubleshoot is not installed
      - 1.6.1.8     # Ensure the MCS Translation Service (mcstrans) is not installed
      - 1.7.1       # Ensure message of the day is configured properly
      - 1.7.2       # Ensure local login warning banner is configured properly
      - 1.7.3       # Ensure remote login warning banner is configured properly
      - 1.7.4       # Ensure permissions on /etc/motd are configured
      - 1.7.5       # Ensure permissions on /etc/issue are configured
      - 1.7.6       # Ensure permissions on /etc/issue.net are configured
      - 1.8.1       # Ensure Gnome display manager is removed
      - 1.8.2       # Ensure GDM login banner is configured
      - 1.8.3       # Ensure GDM disable-user-list option is enabled
      - 1.8.4       # Ensure GDM screen locks when user is idle
      - 1.8.5       # Ensure GDM screen locks cannot be overridden
      - 1.8.6       # Ensure GDM automatic mounting of removable media is disabled
      - 1.8.7       # Ensure GDM disabling automatic mounting of removable media is not overriden
      - 1.8.8       # Ensure GDM autorun-never is enabled
      - 1.8.9       # Ensure GDM autorun-never is not overriden
      - 1.8.10      # Ensure XDCMP is not enabled
      - 1.9         # Ensure updates, patches and additional security software are installed
      - 1.10        # Ensure system-wide crypto policy is not legac
      - 2.1.1       # Ensure time synchronization is in use
      - 2.1.2       # Ensure chrony is configured
      - 2.2         # Ensure unnecessary packages are not installed, services disabled
      - 2.2.15      # Ensure mail transfer agent is configured for local-only mode
      - 2.3         # Ensure service clients are not installed
      - 3.1.1       # IPv6 configuration
      - 3.1.2       # Ensure wireless interfaces are disabled
      - 3.1.3       # Ensure TIPC is disabled
      - 3.2.1       # Ensure IP forwarding is disabled
      - 3.2.2       # Ensure packet redirect sending is disabled
      - 3.3.1       # Ensure source routed packets are not accepte
      - 3.3.2       # Ensure ICMP redirects are not accepted
      - 3.3.3       # Ensure secure ICMP redirects are not accepted
      - 3.3.4       # Ensure suspicious packets are logged
      - 3.3.5       # Ensure broadcast ICMP requests are ignored
      - 3.3.6       # Ensure bogus ICMP responses are ignored
      - 3.3.7       # Ensure Reverse Path Filtering is enabled
      - 3.3.8       # Ensure TCP SYN Cookies is enabled
      - 3.3.9       # Ensure IPv6 router advertisements are not accepted
      - 3.4.1.1     # Ensure nftables is installed
      - 3.4.1.2     # Ensure a single firewall configuration utility is in use 
      - 4.1.1.1     # Ensure auditd is installed
      - 4.1.1.2     # Ensure auditing for processes that start prior to auditd is enabled
      - 4.1.1.3     # Ensure audit_backlog_limit is sufficient
      - 4.1.1.4     # Ensure auditd service is enabled
      - 4.1.2.1     # Ensure audit log storage size is configured
      - 4.1.2.2     # Ensure audit logs are not automatically deleted
      - 4.1.2.3     # Ensure system is disabled when audit logs are full
      - 4.1.3       # Auditd rules
      - 4.1.4.1     # Ensure audit log files are mode 0640 or less permissive  (4.1.4.1 - 4.1.4.2)
      - 4.1.4.3     # Ensure only authorized groups are assigned ownership of audit log files
      - 4.1.4.4     # Ensure the audit log directory is 0750 or more restrictive (4.1.4.4 - 4.1.4.5)
      - 4.1.4.6     # Ensure audit configuration files are owned by root
      - 4.1.4.7     # Ensure audit configuration files belong to root
      - 4.1.4.8     # Ensure audit tools are 755 or more restrictive, owned by root, belong to root (4.1.4.8 - 4.1.4.10)
      - 4.2.1.1     # Ensure rsyslog is installed
      - 4.2.1.2     # Ensure rsyslog service is enabled
      - 4.2.1.3     # Ensure journald is configured to send logs to rsyslog
      - 4.2.1.4     # Ensure rsyslog default file permissions are configured
      - 4.2.1.7     # Ensure rsyslog is not configured to receive logs from a remote client
      - 4.2.2.1.1   # Ensure systemd-journal-remote is installed
      - 4.2.2.1.2   # Ensure systemd-journal-remote is configured
      - 4.2.2.1.3   # Ensure systemd-journal-remote is enabled
      - 4.2.2.1.4   # Ensure journald is not configured to receive logs from a remote client
      - 4.2.2.2     # Ensure journald service is enabled
      - 4.2.2.3     # Ensure journald is configured to compress large log files
      - 4.2.2.4     # Ensure journald is configured to write logfiles to persistent disk
      # - 4.2.2.5     # Ensure journald is not configured to send logs to rsyslog (configured in 4.2.1.3)
      - 4.2.2.6     # Ensure journald log rotation is configured per site policy
      - 4.2.2.7     # Ensure journald default file permissions configured
      - 4.2.3       # Ensure all logfiles have appropriate permissions and ownership
      - 4.3         # Ensure logrotate is configured
      - 5.1.1       # Ensure cron daemon is enabled
      - 5.1.2       # Ensure permissions on /etc/crontab are configured
      - 5.1.3       # Ensure permissions on /etc/cron.hourly are configured
      - 5.1.4       # Ensure permissions on /etc/cron.daily are configured
      - 5.1.5       # Ensure permissions on /etc/cron.weekly are configured
      - 5.1.6       # Ensure permissions on /etc/cron.monthly are configured
      - 5.1.7       # Ensure permissions on /etc/cron.d are configured
      - 5.1.8       # Ensure cron is restricted to authorized users
      - 5.1.9       # Ensure at is restricted to authorized users
      - 5.2.1       # Ensure permissions on /etc/ssh/sshd_config are configured
      - 5.2.2       # Ensure permissions on SSH private host key files are configured
      - 5.2.3       # Ensure permissions on SSH public host key files are configured
      - 5.2.4       # Ensure SSH access is limited
      - 5.2.5       # Ensure SSH LogLevel is appropriate
      - 5.2.6       # Ensure SSH PAM is enabled
      - 5.2.7       # Ensure SSH root login is disabled
      - 5.2.8       # Ensure SSH HostbasedAuthentication is disabled
      - 5.2.9       # Ensure SSH PermitEmptyPasswords is disabled
      - 5.2.10      # Ensure SSH PermitUserEnvironment is disabled
      - 5.2.11      # Ensure SSH IgnoreRhosts is enabled
      - 5.2.12      # Ensure SSH X11 forwarding is disabled
      - 5.2.13      # Ensure SSH AllowTcpForwarding is disabled
      - 5.2.14      # Ensure system-wide crypto policy is not over-ridden
      - 5.2.15      # Ensure SSH warning banner is configured
      - 5.2.16      # Ensure SSH MaxAuthTries is set to 4 or less
      - 5.2.17      # Ensure SSH MaxStartups is configured
      - 5.2.18      # Ensure SSH MaxSessions is set to 10 or less
      - 5.2.19      # Ensure SSH LoginGraceTime is set to one minute or less
      - 5.2.20      # Ensure SSH Idle Timeout Interval is configured
      - 5.3.1       # Ensure sudo is installed
      - 5.3.2       # Ensure sudo commands use pty
      - 5.3.4       # Ensure users must provide password for escalation
      - 5.3.5       # Ensure re-authentication for privilege escalation is not disabled globally
      - 5.3.6       # Ensure sudo authentication timeout is configured correctly
      - 5.3.7       # Ensure access to the su command is restricted
      - 5.4.1       # Ensure custom authselect profile is used
      - 5.4.2       # Ensure authselect includes with-faillock
      - 5.5.1       # Ensure password creation requirements are configured
      - 5.5.2       # Ensure lockout for failed password attempts is configured
      - 5.5.3       # Ensure password reuse is limited
      - 5.5.4       # Ensure password hashing algorithm is SHA-512 or yescrypt
      - 5.6.1.1     # Ensure password expiration is 365 days or less
      - 5.6.1.2     # Ensure minimum days between password changes is configured
      - 5.6.1.3     # Ensure password expiration warning days is 7 or more
      - 5.6.1.4     # Ensure inactive password lock is 30 days or less
      - 5.6.1.5     # Ensure all users last password change date is in the past
      - 5.6.2       # Ensure system accounts are secured
      - 5.6.3       # Ensure default user shell timeout is 900 seconds or less
      - 5.6.4       # Ensure default group for the root account is GID 0
      - 5.6.5       # Ensure default user umask is 027 or more restrictive
      - 5.6.6       # Ensure root password is set
      - 6.1.1       # Ensure permissions on /etc/passwd are configured
      - 6.1.2       # Ensure permissions on /etc/passwd- are configured
      - 6.1.3       # Ensure permissions on /etc/group are configured
      - 6.1.4       # Ensure permissions on /etc/group- are configured
      - 6.1.5       # Ensure permissions on /etc/shadow are configured
      - 6.1.6       # Ensure permissions on /etc/shadow- are configured
      - 6.1.7       # Ensure permissions on /etc/gshadow are configured
      - 6.1.8       # Ensure permissions on /etc/gshadow- are configured
      - 6.1.9       # Ensure no world writable files exist
      - 6.1.10      # Ensure no unowned files or directories exist
      - 6.1.11      # Ensure no ungrouped files or directories exist
      - 6.1.12      # Ensure sticky bit is set on all world-writable directories
      - 6.1.13      # Audit SUID executables
      - 6.1.14      # Audit SGID executables
      - 6.1.15      # Audit system file permissions
      - 6.2.1       # Ensure accounts in /etc/passwd use shadowed passwords
      - 6.2.2       # Ensure /etc/shadow password fields are not empty
      - 6.2.3       # Ensure all groups in /etc/passwd exist in /etc/group
      - 6.2.4       # Ensure no duplicate UIDs exist
      - 6.2.5       # Ensure no duplicate GIDs exist
      - 6.2.6       # Ensure no duplicate user names exist
      - 6.2.7       # Ensure no duplicate group names exist
      - 6.2.8       # Ensure root PATH Integrity
      - 6.2.9       # Ensure root is the only UID 0 account
      - 6.2.10      # Ensure local interactive user home directories exist
      - 6.2.11      # Ensure local interactive users own their home directories
      - 6.2.12      # Ensure local interactive user home directories are mode 750 or more restrictive
      - 6.2.13      # Ensure no local interactive user has .netrc files
      - 6.2.14      # Ensure no local interactive user has .forward files
      - 6.2.15      # Ensure no local interactive user has .rhosts files
      - 6.2.16      # Ensure local interactive user dot files are not group or world writable


    services: # ignore these services
      - chargen-dgram
      - chargen-stream
      - daytime-dgram
      - daytime-stream
      - discard-dgram
      - discard-stream
      - echo-dgram
      - echo-stream
      - time-dgram
      - time-stream
      - tftp
      - xinetd
      - dhcpd
      - slapd
      - nfs
      - nfs-server
      - rpcbind
      - named
      - vsftpd
      - httpd
      - dovecot
      - smb
      - squid
      - snmpd
      - ypserv
      - rsh.socket
      - rlogin.socket
      - rexec.socket
      - telnet.socket
      - tftp.socket
      - rsyncd
      - ntalk

    packages: # ignore these packages
      - ypbind
      - telnet
      - rsh
      - talk
      - avahi-daemon
      - cups
      - openldap-clients
      - xorg-x11-server-Xorg
      - samba

    protocols: # ignore these protocols
      - dccp
      - sctp
      - rds
      - tipc

    filesystems: # ignore these fs
      - cramfs
      - freevxfs
      - jffs2
      - hfs
      - hfsplus
      - squashfs
      - udf
      - vfat

  default:
    auditd:
      backlog_limit: 2000
      space_left_action: email
      action_mail_acct: root
      admin_space_left_action: SUSPEND
      max_log_file_action: ROTATE
    password:
      pass_max_days: 365
      pass_min_days: 1
      pass_warn_age: 7
      minlength: 14
      minclass: 4
      deny: 5 # 5.5.1
      unlock_time: 900 # 5.5.2
      inactive_lock: 30 # 5.6
    selinux:
      mode: enforcing  # (enforcing | permissive | disabled)
    shell:
      timeout: 900
    sshd:
      log_level: INFO
      permit_root_login: prohibit-password
      hostbased_authentication: no
      permit_empty_passwords: no
      permit_user_environment: no
      ignore_rhosts: yes
      x11_forwarding: no
      allow_tcp_forwarding: no
      banner: /etc/issue.net
      max_auth_tries: 3
      max_startups: "10:30:60"
      max_sessions: 10
      login_grace_time: 60
      client_alive_interval: 15
      client_alive_count_max: 3
    sudo:
      log_file: /var/log/sudo.log
      timeout: 5
      su_group_name: sugroup # used to create empty su group (5.3.7)
      su_group_gid: 8501
    journald:
      compress: yes # 4.2.2.3
      storage: persistent # 4.2.2.4
      forward_to_syslog: no # 4.2.2.5
    umask: 
      value: "027"

        # "1.1.2": "Ensure separate partition exists for /tmp",
    # "1.1.3": "Ensure separate partition exists for /var",
    # "1.1.4": "Ensure separate partition exists for /var/tmp",
    # "1.1.5": "Ensure separate partition exists for /var/log",
    # "1.1.6": "Ensure separate partition exists for /var/log/audit",
    # "1.1.7": "Ensure separate partition exists for /home",
    # "1.1.8": "Ensure separate partition exists for /dev/shm",
    # "1.2.1": "Ensure GPG check is configured",
    # "1.2.2": "Ensure gpgcheck is globally activated",
    # "1.2.4": "Ensure repo_gpgcheck is globally activated",
    # "1.3.1": "Ensure AIDE is installed",
    # "1.3.2": "Ensure filesystem integrity is regularly checked",
    # "1.3.3": "Ensure cryptographic mechanisms are used to protect the integrity of audit tools",
    # "1.4.1": "Ensure bootloader password is set",
    # "1.4.2": "Ensure permissions on bootloader config are configured",
    # "1.5.1": "Ensure core dump storage is disabled",
    # "1.5.2": "Ensure core dump backtraces are disabled",
    # "1.5.3": "Ensure address space layout randomization (ASLR) is enabled",
    # "1.6.1.1": "Ensure SELinux is installed",
    # "1.6.1.2": "Ensure SELinux is not disabled in bootloader configuration",
    # "1.6.1.3": "Ensure SELinux policy is configured",
    # "1.6.1.4": "Ensure the SELinux mode is not disabled",
    # "1.6.1.6": "Ensure no unconfined services exist",
    # "1.6.1.7": "Ensure SETroubleshoot is not installed",
    # "1.6.1.8": "Ensure the MCS Translation Service (mcstrans) is not installed",
    # "1.7.1": "Ensure message of the day is configured properly",
    # "1.8.1": "Ensure Gnome display manager is removed",
    # "1.8.2": "Ensure GDM login banner is configured",
    # "1.8.3": "Ensure GDM disable-user-list option is enabled",
    # "5.1": "Cron configuration",
    # "5.2": "SSHD configuration",
    # "5.3": "Sudo configuration",
    # "5.4": "Authselect configuration",
    # "5.5": "PAM configuration",
    # "5.6": "User accounts and environment",
