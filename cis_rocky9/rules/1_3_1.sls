{% set rule = '(1.3.1) Ensure AIDE is installed' %}

{% if salt['pkg.version']('aide') %}
{{ rule }}:
  test.succeed_without_changes:
    - name: {{ rule }} AIDE package is installed
{% else %}
{{ rule }}:
  pkg.installed:
    - name: aide
{% endif %}