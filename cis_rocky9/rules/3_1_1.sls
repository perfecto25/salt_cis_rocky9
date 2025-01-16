{% set rule = '(3.1.1) Disable IPv6' %}

{{ rule }}:
  cmd.run:
    - name: sed -i 's/^GRUB_CMDLINE_LINUX="[^"]*/& ipv6.disable=1/' /etc/default/grub
    - unless: grep GRUB_CMDLINE_LINUX /etc/default/grub | grep ipv6.disable=1
    
{{ rule }} - regenerate grub:
  cmd.run:
    - name: grub2-mkconfig > /boot/grub2/grub.cfg
    - onchanges:
      - cmd: {{ rule }} Disable IPv6

