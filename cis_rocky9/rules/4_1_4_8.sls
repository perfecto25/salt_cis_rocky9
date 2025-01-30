{% set rule = '(4.1.4.8) Ensure audit tools are 755 or more restrictive' %}


{% for file in ['/sbin/auditctl', '/sbin/aureport', '/sbin/ausearch', '/sbin/autrace', '/sbin/auditd', '/sbin/augenrules'] %}
{{ rule }} - {{ file }}:
  file.managed:
    - name: {{ file }}
    - owner: root
    - group: root
    - mode: 0700
{% endfor %}
    