# 1.6.1.8  Ensure the MCS Translation Service (mcstrans) is not installed

{% set rule = '(1.6.1.8)' %}


{{rule}} remove mcstrans pkg:
  pkg.removed:
    - name: mcstrans
