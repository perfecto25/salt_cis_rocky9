# 1.7.4 /etc/motd permissions
# 1.7.5 /etc/issue permissions
# 1.7.6 /etc/issue.net permissions

{% set rule = '(1.7.4)' %}
{{ rule }} Ensure permissions on /etc/motd are configured:
  file.managed:
    - name: /etc/motd
    - user: root
    - group: root
    - mode: "0644"
    - create: False
    - replace: False

{% set rule = '(1.7.5)' %}
  {{ rule }} Ensure permissions on /etc/issue are configured:
    file.managed:
      - name: /etc/issue
      - user: root
      - group: root
      - mode: "0644"
      - create: False
      - replace: False

{% set rule = '(1.7.6)' %}
  {{ rule }} Ensure permissions on /etc/issue.net are configured:
    file.managed:
      - name: /etc/issue.net
      - user: root
      - group: root
      - mode: "0644"
      - create: False
      - replace: False