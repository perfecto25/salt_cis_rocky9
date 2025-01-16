{% set rule = '(1.6.1.8) Ensure the MCS Translation Service (mcstrans) is not installed' %}


{{rule}}:
  pkg.removed:
    - name: mcstrans
