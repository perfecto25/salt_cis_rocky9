# 1.1.5 - configure /var/log
# 1.1.5.1 - ensure separate partition for /var/log
# 1.1.5.2 - ensure nodev option
# 1.1.5.3 - ensure noexec option
# 1.1.5.4 - ensure nosuid option

{% set rule = '(1.1.5)' %}
{% set mnt = '/var/log' %}

{% if salt['mount.is_mounted'](mnt) %}
  {% set options = salt['mount.fstab']()[mnt]['opts'] %}
  {% set fstype = salt['mount.fstab']()[mnt]['fstype'] %}
  {% set device = salt['mount.fstab']()[mnt]['device'] %}

{% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %} # nosuid

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
    - opts:  defaults,rw,nodev,noexec,nosuid
    - persist: True
    - user: root

{% endif %} # if nosuid

{% else %} # if is_mounted

"{{rule}} {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted as separate partition, unable to check nosuid,nodev,noexec !!!

{% endif %} # is_mounted