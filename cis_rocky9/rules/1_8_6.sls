# 1.8.6 Ensure GDM automatic mounting of removable media is disabled


{% set rule = '(1.8.6)' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_6_audit'.format(slspath), cwd='/opt') %}
{% do salt.log.error(retval) -%}
{% do salt.log.error(retval['stdout']) -%}

{% if retval['stdout'] == "FAIL" %}
{{ rule }} Ensure GDM automatic mounting of removable media is disabled:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_6_rem
    - cwd: /opt
{% endif %}

{% endif %}
