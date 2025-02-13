###  GNOME DISPLAY MANAGER

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.8.1" in ignore %}
{% set rule = '(1.8.1) Ensure Gnome display manager is removed' %}
{{ rule }}:
  pkg.removed:
    - name: gdm
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.8.2" in ignore %}
{% set rule = '(1.8.2) Ensure GDM login banner is configured ' %}
{% if "gdm" in salt['pkg.list_pkgs']() %}
{% set retval = salt['cmd.script']('salt://{}/files/1_8_2_audit'.format(slspath), cwd='/opt') %}

{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_2_rem
    - cwd: /opt
{% endif %}
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.8.3" in ignore %}
{% set rule = '(1.8.3) Ensure GDM disable-user-list option is enabled' %}
{% if "gdm" in salt['pkg.list_pkgs']() %}
{% set retval = salt['cmd.script']('salt://{}/files/1_8_3_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_3_rem
    - cwd: /opt
{% endif %}
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.8.4" in ignore %}
{% set rule = '(1.8.4) Ensure GDM screen locks when the user is idle' %}
{% if "gdm" in salt['pkg.list_pkgs']() %}
{% set retval = salt['cmd.script']('salt://{}/files/1_8_4_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_4_rem
    - cwd: /opt
{% endif %}
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.8.5" in ignore %}
{% set rule = '(1.8.5) Ensure GDM screen locks cannot be overridden' %}
{% if "gdm" in salt['pkg.list_pkgs']() %}
{% set retval = salt['cmd.script']('salt://{}/files/1_8_5_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_5_rem
    - cwd: /opt
{% endif %}
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.8.6" in ignore %}
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
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.8.7" in ignore %}
{% set rule = '(1.8.7) Ensure GDM disabling automatic mounting of removable media is not overridden' %}
{% if "gdm" in salt['pkg.list_pkgs']() %}
{% set retval = salt['cmd.script']('salt://{}/files/1_8_7_audit'.format(slspath), cwd='/opt') %}
{% if retval['stdout'] == "FAIL" %}
{{ rule }}:
  cmd.script:
    - source: salt://{{ slspath }}/files/1_8_7_rem
    - cwd: /opt
{% endif %}
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.8.8" in ignore %}
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
{% endif %} # "ignore"

  #-----------------------------------------------------------------------

{% if not "1.8.9" in ignore %}
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
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.8.10" in ignore %}
{% set rule = '(1.8.10) Ensure XDCMP is not enabled' %}
{% if "gdm" in salt['pkg.list_pkgs']() %}
{{ rule }}:
  cmd.run:
    - name: sed -i -e "s/Enable=true/#Enable=true/g" /etc/gdm/custom.conf
    - onlyif: grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm/custom.conf
{% endif %}
{% endif %} # "ignore"

