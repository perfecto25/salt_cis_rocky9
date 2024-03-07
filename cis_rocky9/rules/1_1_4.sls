# 1.1.4 - configure /var/tmp
# 1.1.4.1 - ensure separate partition exists for /var/tmp
# 1.1.4.2 - ensure noexec option set
# 1.1.4.3 - ensure nosuid option set
# 1.1.4.4 - ensure nodev option set


{% set rule = '(1.1.4)' %}
{% set mnt = '/var/tmp' %}

{% if salt['mount.is_mounted'](mnt) %}
  {% set options = salt['mount.fstab']()[mnt]['opts'] %}
  {% set fstype = salt['mount.fstab']()[mnt]['fstype'] %}
  {% set device = salt['mount.fstab']()[mnt]['device'] %}

{% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %}

"{{rule}} {{mnt}} nosuid,nodev,noexec":
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} already set with nosuid,noexec,nodev.

{% else %} # if nosuid

"{{rule}} remount {{mnt}} to set nodev,noexec,nosuid":
  mount.mounted:
    - name: {{mnt}}
    - device: {{device}}
    - fstype: {{fstype}}
    - mkmnt: True
    - opts:  defaults,rw,nodev,noexec,nosuid,seclabel
    - persist: True
    - user: root

{% endif %} # if nosuid

{% else %} # if is_mounted

"{{rule}} {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is not mounted as separate partition, unable to check nosuid,nodev,noexec.

{% endif %}
