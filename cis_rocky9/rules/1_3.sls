### FILESYSTEM INTEGRITY CHECKING

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.3.1" in ignore %}

{% set rule = '(1.3.1) Ensure AIDE is installed' %}
{% if salt['pkg.version']('aide') %}
{{ rule }}:
  test.succeed_without_changes:
    - name: {{ rule }} AIDE package is installed
{% else %}
{{ rule }}:
  pkg.installed:
    - name: aide
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.3.2" in ignore %}
{% set rule = '(1.3.2) Ensure filesystem integrity is regularly checked' %}
  
{% set crons = salt['cron.list_tab']('root')['crons'] %}
{% set cron_present = 'no' %}

{% for cron in crons %}
{% if 'aide' in cron['cmd'] %}
    {% set cron_present = 'yes' %}
{% endif %}
{% endfor %}

{% if cron_present == 'yes' %}
{{ rule }}:
  test.succeed_without_changes:
    - name: AIDE cron is present
{% else %}
{{ rule }}:
  cron.present:
    - name: /usr/sbin/aide --check
    - identifier: AIDE file integrity check
    - user: root
    - minute: 0
    - hour: 5
    - unless: crontab -l -u root | grep 'aide --check'
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.3.3" in ignore %}
{% set rule = '(1.3.3) Ensure cryptographic mechanisms are used to protect the integrity of audit tools' %}

{% set result = salt['cmd.run_all'](cmd="grep -Ps -- '(\/sbin\/(audit|au)\H*\b)' /etc/aide.conf.d/*.conf /etc/aide.conf", python_shell=True) %}

{% if result['stdout'] %}
{{ rule }}:
  test.succeed_without_changes:
    - name: {{ rule }} {{result['stdout']}}

{% else %}

{{ rule }}_aide_marker:
  file.line:
    - name: /etc/aide.conf
    - content: "### cis_start ###\n### cis_end ###"
    - mode: insert
    - location: end
    - create: False 
    - file_mode: "0600"
    - user: root
    - group: root
    - unless: grep "### cis_start" /etc/aide.conf

{{ rule }} - aide audit tools config:
  file.blockreplace:
    - name: /etc/aide.conf
    - marker_start: "### cis_start ###"
    - marker_end: "### cis_end ###"
    - source: salt://{{slspath}}/files/1_3_3
    - onlyif: grep '### cis_start' /etc/aide.conf
    - prereq:
      - file: {{ rule }}_aide_marker
{% endif %}
{% endif %} # "ignore"