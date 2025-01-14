# 1.8.2 Ensure GDM login banner is configured 

{% set rule = '(1.8.2)' %}
{% do salt.log.error("running 182") -%}
{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_2_audit'.format(slspath), cwd='/opt') %}
{% do salt.log.error(retval) -%}
{% do salt.log.error(retval['stdout']) -%}

{% if retval['stdout'] == "FAIL" %}
{{ rule }} Ensure GDM login banner is configured:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_2_rem
    - cwd: /opt

{% endif %}

{% endif %}
