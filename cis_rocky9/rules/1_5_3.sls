# 1.5.3 Ensure address space layout randomization (ASLR) is enabled

{% set rule = '(1.5.3)' %}

{{ rule }} Ensure address space layout randomization is enabled:
  sysctl.present:
    - name: kernel.randomize_va_space
    - value: 2