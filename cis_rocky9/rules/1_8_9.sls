{% set rule = '(1.8.9) Ensure GDM autorun-never is not overridden' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}
{% set retval = salt['cmd.script']('salt://{}/files/1_8_9_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_9_rem
    - cwd: /opt
{% endif %}
{% endif %}
