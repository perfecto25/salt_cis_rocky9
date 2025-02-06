# Sample Pillar showing all possible values that can be configured for CIS compliance

cis_rocky9:
  ignore:
    rules: # ignore these rules
      - 1.1.1
      - 1.1.2
      - 1.1.3
      - 1.1.4
      - 1.1.5
      - 1.1.6
      - 1.1.7
      - 1.1.8
      - 1.2.1
      - 1.2.2
      - 1.2.4
      - 1.3.1
      - 1.3.2
      - 1.3.3
      - 1.4.1
      - 1.4.2
      - 1.5.1
      - 5.2.12 # ssh x11 forwarding
      - 5.3 # sudo
      - 5.4 # authselect
      - 5.5 # password complexity

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
    shell:
      timeout: 600
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


