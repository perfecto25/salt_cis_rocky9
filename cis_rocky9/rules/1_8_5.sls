# 1.8.5 Ensure GDM screen locks cannot be overridden


{% set rule = '(1.8.5)' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_5_audit'.format(slspath), cwd='/opt') %}
{% do salt.log.error(retval) -%}
{% do salt.log.error(retval['stdout']) -%}

{% if retval['stdout'] == "FAIL" %}
{{ rule }} Ensure GDM screen locks when the user is idle:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_5_rem
    - cwd: /opt

{% endif %}

{% endif %}
