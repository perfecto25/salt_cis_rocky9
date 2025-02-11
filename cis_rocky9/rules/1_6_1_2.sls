{% set rule = '(1.6.1.2) Ensure SELinux is not disabled in bootloader configuration' %}

{% set out = salt['service.status'](cmd="grubby --info=ALL | egrep '(selinux|enforcing)=0'", python_shell=True)["stdout"] %}

{{ rule }}:
{% if not out %}
  test.succeed_without_changes:
    - name: "{{ rule }} SELinux is enabled in bootloader"
{% else %}
  cmd.run:
    - name: grubby --update-kernel=ALL --remove-args "selinux=0 enforcing=0"
{% endif %}