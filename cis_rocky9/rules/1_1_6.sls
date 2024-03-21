# 1.1.6 - configure /var/log/audit
# 1.1.6.1 - ensure separate partition for /var/log/audit
# 1.1.6.2 - ensure nodev option
# 1.1.6.3 - ensure noexec option
# 1.1.6.4 - ensure nosuid option

{% set rule = '(1.1.6)' %}
{% set mnt = '/var/log/audit' %}

{% if salt['mount.is_mounted'](mnt) %} # is_mounted

{% if salt['mount.fstab']()[mnt] is defined %} # mnt 
{% if salt['mount.fstab']()[mnt]['opts'] is defined %} # opts
{% set options = salt['mount.fstab']()[mnt]['opts'] %}
{% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %} # no suid

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
{% endif %} # opts

{% if salt['mount.fstab']()[mnt]['fstype'] is defined %}{% set fstype = salt['mount.fstab']()[mnt]['fstype'] %}{% endif %}
{% if salt['mount.fstab']()[mnt]['device'] is defined %}{% set device = salt['mount.fstab']()[mnt]['device'] %}{% endif %}
    
{% endif %} # mnt

{% else %} # is_mounted

"{{rule}} {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted as separate partition, unable to check nosuid,nodev,noexec !!!

{% endif %} # is_mounted
