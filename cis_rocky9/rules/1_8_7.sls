# 1.8.7 Ensure GDM disabling automatic mounting of removable media is not overridden


{% set rule = '(1.8.7)' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_7_audit'.format(slspath), cwd='/opt') %}
{% do salt.log.error(retval) -%}
{% do salt.log.error(retval['stdout']) -%}

{% if retval['stdout'] == "FAIL" %}
{{ rule }} Ensure GDM disabling automatic mounting of removable media is not overridden:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_7_rem
    - cwd: /opt
{% endif %}

{% endif %}
