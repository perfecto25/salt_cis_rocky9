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