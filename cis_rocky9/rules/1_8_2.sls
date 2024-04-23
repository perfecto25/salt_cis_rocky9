# 1.8.2 Ensure GDM login banner is configured 

{% set rule = '(1.8.2)' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}
{% for file in salt['file.readdir']('/etc/dconf/db/gdm.d/') %}


{% do salt.log.error(file) -%}

{% endfor %}
{% endif %}