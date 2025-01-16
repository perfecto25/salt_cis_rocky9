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