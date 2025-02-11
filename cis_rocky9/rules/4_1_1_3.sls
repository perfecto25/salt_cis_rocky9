{% set rule = '(4.1.1.3) Ensure audit_backlog_limit is sufficient' %}

{% set limit = salt['pillar.get']('cis_rocky9:default:auditd:backlog_limit', '8192') %}

{% set ret = salt['cmd.run_all'](cmd='grubby --info=ALL | grep -o "audit_backlog_limit=[0-9].*[0-9]" | cut -d"=" -f2', python_shell=True)['stdout'].split('\n') %}

{% set ns = namespace(flag=0) %}


{% if ret %}
## check if current limit settings for each kernel are below configured value
{% for retval in ret %}
  {% if retval|int < limit|int %}
    {% set ns.flag = 1 %}
  {% endif %}
{% endfor %}


  {% if ns.flag == 1 %}
{{ rule }}:
  cmd.run:
    - name: grubby --update-kernel ALL --args 'audit_backlog_limit={{ limit }}'
  {% endif %}

{% else %}

## no kernels have any config for limit, updating kernels with backlog limit
{{ rule }}:
  cmd.run:
    - name: grubby --update-kernel ALL --args 'audit_backlog_limit={{ limit }}'

{% endif %}


