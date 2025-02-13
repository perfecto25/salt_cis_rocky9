### SECURE BOOT SETTINGS 
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.4.1" in ignore %}
{% set rule = '(1.4.1) Ensure bootloader password is set' %}
{% if salt['file.file_exists']("/boot/grub2/user.cfg") %}
  {% if salt['file.search']("/boot/grub2/user.cfg", "^GRUB2_PASSWORD=grub.pbkdf2.sha512") %}
{{ rule }}:
  test.succeed_without_changes:
    - name: {{ rule }} Bootloader password is set
  {% else %}
{{ rule }}:
  test.fail_without_changes:
    - name: {{ rule }} set a bootloader password by running 'grub2-setpassword'
  {% endif %}
{% else %}
{{ rule }}:
  test.fail_without_changes:
    - name: {{ rule }} set a bootloader password by running 'grub2-setpassword'
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.4.2" in ignore %}
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
{% endif %} # "ignore"