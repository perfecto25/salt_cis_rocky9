{% set rule = '(1.10) Ensure system-wide crypto policy is not legacy' %}

{{ rule }}:
  cmd.run:
    - name: update-crypto-policies --set DEFAULT
    - onlyif: grep -E -i '^\s*LEGACY\s*(\s+#.*)?$' /etc/crypto-policies/config
