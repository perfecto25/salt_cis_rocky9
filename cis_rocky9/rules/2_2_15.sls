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