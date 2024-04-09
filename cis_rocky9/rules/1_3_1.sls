# 1.3.1 Ensure AIDE is installed

{% set rule = '(1.3.1)' %}

{% if salt['pkg.version']('aide') %}
{{ rule }} ensure AIDE package is installed:
  test.succeed_without_changes:
    - name: {{ rule }} AIDE package is installed
{% else %}
{{ rule }} ensure AIDE package is installed:
  pkg.installed:
    - name: aide
{% endif %}