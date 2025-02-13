
### FILESYSTEM CONFIGURATION
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.1.1" in ignore %}
{% set rule = '(1.1.1) Disable unused filesystems' %}
{% set filesystems = ['squashfs', 'udf'] %}
{% for fs in filesystems %}
{% if not fs in salt['pillar.get']('cis_rocky9:ignore:filesystems') %}
{% set status = salt['cmd.run']('modprobe -n -v {}'.format(fs)) %}
{% if status == 'install /bin/true' %}
{{ rule }} - {{ fs }} mounting is disabled:
  test.succeed_without_changes:
    - name: {{ rule }} {{ fs }} mounting is already disabled.
{% else %}
{{ rule }} - {{ fs }} create modrobe blacklist:
  cmd.run:
    - name: touch /etc/modprobe.d/salt_cis.conf
    - unless: test -f /etc/modprobe.d/salt_cis.conf
{{ rule }} - {{ fs }} disabled:
  file.replace:
    - name: /etc/modprobe.d/salt_cis.conf
    - pattern: "^blacklist {{ fs }}"
    - repl: blacklist {{ fs }}
    - append_if_not_found: True 
  cmd.run:
    - name: modprobe -r {{ fs }} && rmmod {{ fs }}
    - onlyif: "lsmod | grep {{ fs }}"
{% endif %}
{% endif %}
{% endfor %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.1.2" in ignore %}
{% set rule = '(1.1.2) Configure /tmp' %}
{% if salt['mount.is_mounted']('/tmp') %}
{{ rule }} - /tmp on separate partition:
  test.succeed_without_changes:
    - name: {{ rule }} /tmp is already mounted on separate partition.
{% else %}
{{ rule }} - tmp mount unmask:
  service.unmasked:
    - name: tmp.mount

{{ rule }} - tmp mount enabled:
  service.enabled:
    - name: tmp.mount

{{ rule }} - tmp mount config:
  file.managed:
    - name: /etc/systemd/system/local-fs.target.wants/tmp.mount
    - source: salt://{{ slspath }}/files/1_1_2_tmp_mount
    - user: root
    - group: root
    - mode: "0644"

{{ rule }} - /tmp on separate partition:
  mount.mounted:
    - name: /tmp
    - device: tmpfs
    - fstype: tmpfs 
    - mkmnt: True
    - persist: True
    - opts:
      - nodev
      - nosuid 
      - noexec
{% endif %}

{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.1.3" in ignore %}

{% set rule = '(1.1.3) Configure /var' %}
{% set mnt = '/var' %}
{% if salt['mount.is_mounted'](mnt) %}  # mnt

{% set options = salt['mount.fstab']()[mnt]['opts'] %}
{% set fstype = salt['mount.fstab']()[mnt]['fstype'] %}
{% set device = salt['mount.fstab']()[mnt]['device'] %}

{% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %} # nosuid

"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} already set with nosuid,noexec,nodev.

{% else %} # if nosuid

"{{rule}} - remount {{mnt}} to set nodev,noexec,nosuid":
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

"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted as separate partition, unable to check nosuid,nodev,noexec !!!
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.1.4" in ignore %}

{% set rule = '(1.1.4) Configure /var/tmp' %}
{% set mnt = '/var/tmp' %}
{% if salt['mount.is_mounted'](mnt) %} # is_mounted
  {% set options = salt['mount.fstab']()[mnt]['opts'] %}
  {% set fstype = salt['mount.fstab']()[mnt]['fstype'] %}
  {% set device = salt['mount.fstab']()[mnt]['device'] %}

  {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %} # nosuid

"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} already set with nosuid,noexec,nodev.

  {% else %} # if nosuid

"{{rule}} - remount {{mnt}} to set nodev,noexec,nosuid":
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

"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted as separate partition, unable to check nosuid,nodev,noexec !!!
{% endif %}

{% endif %} # "ignore"


#-----------------------------------------------------------------------

{% if not "1.1.5" in ignore %}
{% set rule = '(1.1.5) Configure /var/log' %}
{% set mnt = '/var/log' %}

{% if salt['mount.is_mounted'](mnt) %}
  {% set options = salt['mount.fstab']()[mnt]['opts'] %}
  {% set fstype = salt['mount.fstab']()[mnt]['fstype'] %}
  {% set device = salt['mount.fstab']()[mnt]['device'] %}

  {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %} # nosuid

"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} already set with nosuid,noexec,nodev.

  {% else %} # if nosuid

"{{rule}} - remount {{mnt}} to set nodev,noexec,nosuid":
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
"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted as separate partition, unable to check nosuid,nodev,noexec !!!
{% endif %} # is_mounted

{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.1.6" in ignore %}
{% set rule = '(1.1.6) Configure /var/log/audit' %}
{% set mnt = '/var/log/audit' %}
{% if salt['mount.is_mounted'](mnt) %} # is_mounted
{% if salt['mount.fstab']()[mnt] is defined %} # mnt 
  {% if salt['mount.fstab']()[mnt]['opts'] is defined %} # opts
    {% set options = salt['mount.fstab']()[mnt]['opts'] %}
    {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %} # no suid
"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} already set with nosuid,noexec,nodev.

    {% else %} # if nosuid

"{{rule}} - remount {{mnt}} to set nodev,noexec,nosuid":
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

"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted as separate partition, unable to check nosuid,nodev,noexec !!!
{% endif %} # is_mounted
{% endif %} # "ignore"



#-----------------------------------------------------------------------

{% if not "1.1.7" in ignore %}
{% set rule = '(1.1.7) Configure /home' %}
{% set mnt = '/home' %}
{% if salt['mount.is_mounted'](mnt) %}
{{rule}} - {{mnt}} on separate partition:
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} is already mounted on separate partition.
{% else %}
{{ rule }} - /home on separate partition:
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted on a separate partition !!!  
{% endif %}
{% endif %} # "ignore"


#-----------------------------------------------------------------------

{% if not "1.1.8" in ignore %}
{% set rule = '(1.1.8)' %}
{% set mnt = '/dev/shm' %}

{% if salt['mount.is_mounted'](mnt) %} # is_mounted

  {% if salt['mount.fstab'][mnt] is defined %} # mnt_exists
    {% if salt['mount.fstab']()[mnt]['opts'] is defined %} # opts
      {% set options = salt['mount.fstab']()[mnt]['opts'] %}
      {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %} # nosuid,noexec

"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} already set with nosuid,noexec,nodev.
      
      {% else %} # nosuid,noexec

      {% if salt['mount.fstab']()[mnt]['fstype'] is defined %}{% set fstype = salt['mount.fstab']()[mnt]['fstype'] %}{% endif %}
      {% if salt['mount.fstab']()[mnt]['device'] is defined %}{% set device = salt['mount.fstab']()[mnt]['device'] %}{% endif %}

      {% if fstype is defined and device is defined %} # fstype,device
"{{rule}} - remount {{mnt}} to set nodev,noexec,nosuid":
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

"{{rule}} - {{mnt}} nosuid,nodev,noexec":
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted as separate partition, unable to check nosuid,nodev,noexec !!!
{% endif %} # is_mounted
{% endif %} # mnt defined
{% endif %} # "ignore"
