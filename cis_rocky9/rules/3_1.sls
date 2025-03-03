###  Disable unused network protocols and devices

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "3.1.1" in ignore %}
{% set rule = '(3.1.1) Disable IPv6' %}
{{ rule }}:
  cmd.run:
    - name: sed -i 's/^GRUB_CMDLINE_LINUX="[^"]*/& ipv6.disable=1/' /etc/default/grub
    - unless: grep GRUB_CMDLINE_LINUX /etc/default/grub | grep ipv6.disable=1

{{ rule }} - regenerate grub:
  cmd.run:
    - name: grub2-mkconfig > /boot/grub2/grub.cfg
    - onchanges:
      - cmd: {{ rule }} Disable IPv6
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.1.2" in ignore %}
{% set rule = '(3.1.2) Ensure wireless interfaces are disabled' %}
{% set ret = salt['cmd.script']('salt://{}/files/3_1_2_audit'.format(slspath), cwd='/opt') %}
{# do salt.log.error(ret) -#}
{% if ret['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/3_1_2_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "3.1.3" in ignore %}
{% set rule = '(3.1.3) Ensure TIPC is disabled' %}
{% set ret = salt['cmd.script']('salt://{}/files/3_1_3_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/3_1_3_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"
