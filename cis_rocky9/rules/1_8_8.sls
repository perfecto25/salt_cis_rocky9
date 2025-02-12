{% set rule = '(1.8.8) Ensure GDM autorun-never is enabled' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_8_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_8_rem
    - cwd: /opt
{% endif %}
{% endif %}
