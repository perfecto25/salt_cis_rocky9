# 1.1.2 - configure /tmp
# 1.1.2.1 - ensure /tmp is a separate partition
# 1.1.2.2 - ensure nodev option set
# 1.1.2.3 - ensure noexec option set
# 1.1.2.4 - ensure nosuid option set


{% set rule = '(1.1.2)' %}

{% if salt['mount.is_mounted']('/tmp') %}

{{ rule }} /tmp on separate partition:
    test.succeed_without_changes:
        - name: {{ rule }} /tmp is already mounted on separate partition.

{% else %}

{{ rule }} tmp mount unmask:
    service.unmasked:
        - name: tmp.mount

{{ rule }} tmp mount enabled:
    service.enabled:
        - name: tmp.mount

{{ rule }} tmp mount config:
    file.managed:
        - name: /etc/systemd/system/local-fs.target.wants/tmp.mount
        - source: salt://{{ slspath }}/files/1_1_2_tmp_mount
        - user: root
        - group: root
        - mode: 644

{{ rule }} /tmp on separate partition:
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