# 1.8.3 Ensure GDM disable-user-list option is enabled

# Description:
# GDM is the GNOME Display Manager which handles graphical login for GNOME based
# systems.
# The disable-user-list option controls if a list of users is displayed on the login screen

# Rationale:
# Displaying the user list eliminates half of the Userid/Password equation that an
# unauthorized person would need to log on.

{% set rule = '(1.8.3)' %}

{% if "gdm" in salt['pkg.list_pkgs']() %}

{% set retval = salt['cmd.script']('salt://{}/files/1_8_3_audit'.format(slspath), cwd='/opt') %}
{% do salt.log.error(retval) -%}
{% do salt.log.error(retval['stdout']) -%}

{% if retval['stdout'] == "FAIL" %}
{{ rule }} Ensure GDM disable-user-list option is enabled:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_3_rem
    - cwd: /opt

{% endif %}

{% endif %}
