# 1.1.8 - configure /dev/shm
# 1.1.8.1 - ensure separate partition
# 1.1.8.2 - ensure nodev option
# 1.1.8.3 - ensure noexec option
# 1.1.8.4 - ensure nosuid option

{% set rule = '(1.1.8)' %}
{% set mnt = '/dev/shm' %}

{% if salt['mount.is_mounted'](mnt) %} # is_mounted

{% if salt['mount.fstab'][mnt] is defined %} # mnt_exists
{% if salt['mount.fstab']()[mnt]['opts'] is defined %} # opts
{% set options = salt['mount.fstab']()[mnt]['opts'] %}
{% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %} # nosuid,noexec

"{{rule}} {{mnt}} nosuid,nodev,noexec":
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} already set with nosuid,noexec,nodev.
      
{% else %} # nosuid,noexec

{% if salt['mount.fstab']()[mnt]['fstype'] is defined %}{% set fstype = salt['mount.fstab']()[mnt]['fstype'] %}{% endif %}
{% if salt['mount.fstab']()[mnt]['device'] is defined %}{% set device = salt['mount.fstab']()[mnt]['device'] %}{% endif %}

{% if fstype is defined and device is defined %} # fstype,device
"{{rule}} remount {{mnt}} to set nodev,noexec,nosuid":
  mount.mounted:
    - name: {{mnt}}
    - device: {{device}}
    - fstype: {{fstype}}
    - mkmnt: True
    - opts:  defaults,rw,nodev,noexec,nosuid
    - persist: True
    - user: root
{% endif %} # fstype,device

{% endif %} # nosuid,noexec    
{% endif %} # opts

{% else %} # is_mounted

"{{rule}} {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted as separate partition, unable to check nosuid,nodev,noexec !!!

{% endif %} # is_mounted
{% endif %} # mnt defined