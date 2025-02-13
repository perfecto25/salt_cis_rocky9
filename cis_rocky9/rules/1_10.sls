### CRYPTO POLICY 

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.10" in ignore %}
{% set rule = '(1.10) Ensure system-wide crypto policy is not legacy' %}
{{ rule }}:
  cmd.run:
    - name: update-crypto-policies --set DEFAULT
    - onlyif: grep -E -i '^\s*LEGACY\s*(\s+#.*)?$' /etc/crypto-policies/config
{% endif %} # "ignore"