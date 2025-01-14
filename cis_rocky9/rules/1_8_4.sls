# 1.8.4 Ensure GDM screen locks when the user is idle


{% set rule = '(1.8.4)' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_4_audit'.format(slspath), cwd='/opt') %}
{% do salt.log.error(retval) -%}
{% do salt.log.error(retval['stdout']) -%}

{% if retval['stdout'] == "FAIL" %}
{{ rule }} Ensure GDM screen locks when the user is idle:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_4_rem
    - cwd: /opt

{% endif %}

{% endif %}
