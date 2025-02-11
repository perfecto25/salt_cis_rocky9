{% set rule = '(1.8.7) Ensure GDM disabling automatic mounting of removable media is not overridden' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_7_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_7_rem
    - cwd: /opt
{% endif %}

{% endif %}
