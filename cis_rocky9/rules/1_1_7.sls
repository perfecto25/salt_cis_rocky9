# 1.1.7 - configure /home
# 1.1.7.1 - ensure separate partition for /home
# 1.1.7.2 - ensure nodev option
# 1.1.7.3 - ensure nosuid option

{% set rule = '(1.1.7)' %}
{% set mnt = '/home' %}

{% if salt['mount.is_mounted'](mnt) %}

{{rule}} {{mnt}} on separate partition:
  test.succeed_without_changes:
    - name: {{rule}} {{mnt}} is already mounted on separate partition.

{% else %}

{{ rule }} /home on separate partition:
  test.fail_without_changes:
    - name: {{rule}} {{mnt}} is NOT mounted on a separate partition !!!

{% endif %}