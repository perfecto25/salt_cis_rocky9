# 1.1.3 - configure /var
# 1.1.3.1 - ensure separate partition exists for /var
# 1.1.3.2 - ensure nodev option set
# 1.1.3.3 - ensure nosuid option set


{% set rule = '(1.1.3)' %}

{% if salt['mount.is_mounted']('/var') %}
  {% set options = salt['mount.fstab']()['/var']['opts'] %}
  {% set fstype = salt['mount.fstab']()['/var']['fstype'] %}
  {% set device = salt['mount.fstab']()['/var']['device'] %}

    {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %}

{{ rule }} /var nosuid,nodev,noexec:
  test.succeed_without_changes:
    - name: {{ rule }} /var already set with nosuid,noexec,nodev.

    {% else %}


{{ rule }} unmount /var:
  mount.unmounted:
    - name: var
    - device: /var   

{{ rule }} remount /var to set nodev,noexec,nosuid:
  mount.mounted:
    - name: /var
    - device: {{device}}
    - fstype: {{fstype}}
    - mkmnt: True
    - opts:  defaults,rw,nodev,noexec,nosuid,seclabel
    - persist: True
    - user: root

    {% endif %}

{% else %}
{{ rule }} /var nosuid,nodev,noexec:
  test.fail_without_changes:
    - name: {{ rule }} /var is not mounted as separate partition, unable to check nosuid,nodev,noexec.
{% endif %}
