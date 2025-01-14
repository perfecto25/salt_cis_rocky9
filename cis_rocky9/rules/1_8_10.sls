# 1.8.10 Ensure XDCMP is not enabled


{% set rule = '(1.8.10)' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{{ rule }} Ensure GDM autorun-never is not overridden:
  cmd.run:
    - name: sed -i -e "s/Enable=true/#Enable=true/g" /etc/gdm/custom.conf
    - onlyif: grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm/custom.conf

{% endif %}
