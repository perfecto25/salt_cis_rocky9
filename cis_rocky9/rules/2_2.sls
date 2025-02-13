# 2.2 Special Purpose Services
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "2.2" in ignore %}
{% set rule = '(2.2) Ensure package is not installed' %}
{% for pkg in [
  'xorg-x11-server-common',
  'avahi',
  'cups',
  'dhcp-server',
  'bind',
  'vsftpd',
  'tftp-server',
  'nginx',
  'httpd',
  'dovecot',
  'cyrus-imapd',
  'samba',
  'squid',
  'net-snmp',
  'telnet-server',
  'dnsmasq',
  'nfs-utils',
  'rpcbind',
  'rsync-daemon',
] 
%}

{% if pkg not in salt['pillar.get']('cis_rocky9:ignore:packages') %}
{{ rule }} - {{ pkg }}:
  pkg.removed:
    - name: {{ pkg }}
{% endif %}
{% endfor %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "2.2.15" in ignore %}
{% set rule = '(2.2.15) Ensure mail transfer agent is configured for local only mode' %}
{% if 'postfix' not in salt['pillar.get']('cis_rocky9:ignore:packages') and salt['pkg.version']('postfix') %}
{{ rule }}:
  cmd.run:
    - name: sed -i  's\^inet_interfaces.*\inet_interfaces = loopback-only\g' /etc/postfix/main.cf
    - unless: grep ^"inet_interfaces = loopback-only" /etc/postfix/main.cf
    - watch_in:
      - service: postfix
  service.running:
    - name: postfix
    - enable: True
{% endif %}
{% endif %} # "ignore"