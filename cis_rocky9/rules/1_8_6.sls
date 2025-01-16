{% set rule = '(1.8.6) Ensure GDM automatic mounting of removable media is disabled' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_6_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_6_rem
    - cwd: /opt
{% endif %}
{% endif %}
