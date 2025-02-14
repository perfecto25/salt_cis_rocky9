###  Ensure updates, patches, and additional security software are installed

{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "1.9" in ignore %}
{% set rule = '(1.9) Ensure updates, patches, and additional security software are installed' %}
{% set result = salt['cmd.run_all']("dnf needs-restarting -r") %}
{% if result['retcode'] == 1 %}
{{ rule }}:
  test.fail_without_changes:
    - name: "{{ rule }} DNF updates is pending a reboot"
{% endif %}
{% endif %} # "ignore"