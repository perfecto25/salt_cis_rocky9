{% set rule = '(1.4.2) Ensure permissions on bootloader config are configured' %}

{% set files = ['/boot/grub2/grub.cfg', '/boot/grub2/user.cfg', '/boot/grub2/grubenv'] %}

{% for file in files %}
{% if salt['file.file_exists'](file) %}
{{ rule }} - {{ file }}:
  file.managed:
    - name: {{ file }}
    - user: root
    - group: root
    - mode: "0600"
    - create: False
{% endif %}
{% endfor %}