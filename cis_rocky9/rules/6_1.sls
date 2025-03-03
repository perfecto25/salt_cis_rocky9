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
    - name: "World writable files found (first 20 results):\n\n{% for file in ret['stdout'].split('\n')[:20] %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.1.10" in ignore %}
{% set rule = '(6.1.10) Ensure no unowned files or directories exist' %}
{% set ret = salt['cmd.run_all'](cmd="df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser", python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Un-owned files found (first 20 results):\n\n{% for file in ret['stdout'].split('\n')[:20] %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"


#-----------------------------------------------------------------------

{% if not "6.1.11" in ignore %}
{% set rule = '(6.1.11) Ensure no ungrouped files or directories exist' %}
{% set ret = salt['cmd.run_all'](cmd="df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup", python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Ungrouped files or directories found (first 20 results):\n\n{% for file in ret['stdout'].split('\n')[:20] %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.1.12" in ignore %}
{% set rule = '(6.1.12) Ensure sticky bit is set on all world-writable directories' %}
{% set ret = salt['cmd.run_all'](cmd="df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null", python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Sticky bit not set on world-writeable directories (first 20 results):\n\n{% for file in ret['stdout'].split('\n')[:20] %} - {{ file }}\n{% endfor %}\n\n(Changing to add sticky bit)\n\n"
  cmd.run:
    - name: df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | xargs -I '{}' chmod a+t '{}'
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.1.13" in ignore %}
{% set rule = '(6.1.13) Audit SUID executables' %}

{% set ret = salt['cmd.run_all'](cmd="df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000", python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "SUID executables found (first 20 results):\n\n{% for file in ret['stdout'].split('\n')[:20] %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.1.14" in ignore %}
{% set rule = '(6.1.14) Audit SGID executables' %}
{% set ret = salt['cmd.run_all'](cmd="df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000", python_shell=True) %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "SGID executables found (first 20 results):\n\n{% for file in ret['stdout'].split('\n')[:20] %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "6.1.15" in ignore %}
{% set rule = '(6.1.15) Audit system file permissions' %}
{% set ret = salt['cmd.script']('salt://{}/files/6_1_15_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] %}
{{ rule }}:
  test.fail_without_changes:
    - name: "Executable binaries on disk differ from original RPM package:\n\n{% for file in ret['stdout'].split('\n') %} - {{ file }}\n{% endfor %}"
{% endif %}
{% endif %} # "ignore"