###  COMMAND LINE WARNING BANNERS

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.7.1" in ignore %}
{% set rule = '(1.7.1) Ensure MOTD is configured properly' %}
{% set retval = salt['cmd.script']('salt://{}/files/1_7_audit'.format(slspath), cwd='/opt', args='/etc/motd') %}
{% if retval['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "{{ rule }} /etc/motd contains OS release information"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.7.2" in ignore %}
{% set rule = '(1.7.2) Ensure local login warning banner is configured properly' %}
{% set retval = salt['cmd.script']('salt://{}/files/1_7_audit'.format(slspath), cwd='/opt', args='/etc/issue') %}
{% if retval['stdout'] %}
{{ rule }} - /etc/issue:
  file.managed:
    - name: /etc/issue
    - user: root
    - group: root
    - mode: "0644"
    - source: salt://{{ slspath }}/files/1_7_2_rem
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.7.3" in ignore %}
{% set rule = '(1.7.3) Ensure remote login warning banner is configured properly' %}
{% set retval = salt['cmd.script']('salt://{}/files/1_7_audit'.format(slspath), cwd='/opt', args='/etc/issue.net') %}
{% if retval['stdout'] %}
{{ rule }} - /etc/issue.net:
  file.managed:
    - name: /etc/issue.net
    - user: root
    - group: root
    - mode: "0644"
    - source: salt://{{ slspath }}/files/1_7_2_rem
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.7.4" in ignore %}
{% set rule = '(1.7.4) Ensure permissions on /etc/motd are configured' %}
{{ rule }}:
  file.managed:
    - name: /etc/motd
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - replace: False
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.7.5" in ignore %}
{% set rule = '(1.7.5) Ensure permissions on /etc/issue are configured' %}
{{ rule }}:
  file.managed:
    - name: /etc/issue
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - replace: False
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.7.6" in ignore %}
{% set rule = '(1.7.6) Ensure permissions on /etc/issue.net are configured' %}
{{ rule }}:
  file.managed:
    - name: /etc/issue.net
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - replace: False
{% endif %} # "ignore"


