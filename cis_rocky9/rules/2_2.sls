# 2.2 Special Purpose Services

{% set rule = '(2.2)' %}

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

{{ rule }} ensure package {{ pkg }} is not installed:
  pkg.removed:
    - name: {{ pkg }}

{% endif %}
{% endfor %}