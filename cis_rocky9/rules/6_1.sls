###  System File Permissions
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}


{% set rules = {
  '6.1.1': ['/etc/passwd', '0644'],
  '6.1.2': ['/etc/passwd-', '0644'],
  '6.1.3': ['/etc/group', '0644'],
  '6.1.4': ['/etc/group-', '0644'],
  '6.1.5': ['/etc/shadow', '0000'],
  '6.1.6': ['/etc/shadow-', '0000'],
  '6.1.7': ['/etc/gshadow', '0000'],
  '6.1.8': ['/etc/gshadow-', '0000'],
} 
%}

{% for number, rule in rules.items() %}
{% if not number in ignore %}
({{ number }}) Ensure permissions on {{ rule[0] }} are configured:
  file.managed:
    - name: {{ rule[0] }}
    - user: root
    - group: root
    - mode: "{{ rule[1] }}"
    - create: False
    - replace: False
{% endif %}
{% endfor %}

#-----------------------------------------------------------------------

{% if not "6.1.9" in ignore %}
{% set rule = '(6.1.9) Ensure no world writable files exist' %}
{% set ret = salt['cmd.run_all'](cmd="df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002", python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "World writable files found:\n\n{% for file in ret['stdout'].split('\n') %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.1.10" in ignore %}
{% set rule = '(6.1.10) Ensure no unowned files or directories exist' %}
{% set ret = salt['cmd.run_all'](cmd="df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser", python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Un-owned files found:\n\n{% for file in ret['stdout'].split('\n') %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"


#-----------------------------------------------------------------------

{% if not "6.1.11" in ignore %}
{% set rule = '(6.1.11) Ensure no ungrouped files or directories exist' %}
{% set ret = salt['cmd.run_all'](cmd="df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup | cu", python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Ungrouped files or directories found (first 20 results):\n\n{% for file in ret['stdout'].split('\n')[:20] %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.4" in ignore %}




{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.6" in ignore %}



{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.7" in ignore %}



{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.6.1.8" in ignore %}



{% endif %} # "ignore"