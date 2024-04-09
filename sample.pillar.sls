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
      space_left_action: email
      action_mail_acct: root
      admin_space_left_action: SUSPEND
      max_log_file_action: ROTATE
    password:
      pass_max_days: 90
      pass_min_days: 7
      pass_warn_age: 7
    shell:
      timeout: 600
