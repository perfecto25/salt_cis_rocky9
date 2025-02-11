# 1.1.1 Disable unused filesystems


{% set rule = '(1.1.1)' %}

{% set filesystems = ['squashfs', 'udf'] %}

{% for fs in filesystems %}
{% if not fs in salt['pillar.get']('cis_rocky9:ignore:filesystems') %}
{% set status = salt['cmd.run']('modprobe -n -v {}'.format(fs)) %}
{% if status == 'install /bin/true' %}

{{ rule }} {{ fs }} mounting is disabled:
  test.succeed_without_changes:
    - name: {{ rule }} {{ fs }} mounting is already disabled.

{% else %}

{{ rule }} {{ fs }} create modrobe blacklist:
  cmd.run:
    - name: touch /etc/modprobe.d/salt_cis.conf
    - unless: test -f /etc/modprobe.d/salt_cis.conf

{{ rule }} {{ fs }} disabled:
    file.replace:
        - name: /etc/modprobe.d/salt_cis.conf
        - pattern: "^blacklist {{ fs }}"
        - repl: blacklist {{ fs }}
        - append_if_not_found: True 
    cmd.run:
        - name: modprobe -r {{ fs }} && rmmod {{ fs }}
        - onlyif: "lsmod | grep {{ fs }}"

{% endif %}
{% endif %}
{% endfor %}
