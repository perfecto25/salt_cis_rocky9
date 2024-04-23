# 1.8.1 Ensure Gnome display manager is removed

{% set rule = '(1.8.1)' %}
{{ rule }} Ensure Gnome display manager is removed:
  pkg.removed:
    - name: gdm