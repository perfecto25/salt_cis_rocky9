{% set rule = '(1.8.1) Ensure Gnome display manager is removed' %}
{{ rule }}:
  pkg.removed:
    - name: gdm