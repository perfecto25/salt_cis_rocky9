# 1.4.2 Ensure bootloader password is set

{% set rule = '(1.4.1)' %}


{% if salt['file.file_exists']("/boot/grub2/user.cfg") %}

{% if salt['file.search']("/boot/grub2/user.cfg", "^GRUB2_PASSWORD=grub.pbkdf2.sha512") %}
{{ rule }} Ensure bootloader password is set:
  test.succeed_without_changes:
    - name: {{ rule }} Bootloader password is set
{% else %}
{{ rule }} Ensure bootloader password is set:
  test.fail_without_changes:
    - name: {{ rule }} set a bootloader password by running 'grub2-setpassword'
{% endif %}

{% else %}

{{ rule }} Ensure bootloader password is set:
  test.fail_without_changes:
    - name: {{ rule }} set a bootloader password by running 'grub2-setpassword'
{% endif %}