###  MANDATORY ACCESS CONTROL
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}

{% if not "4.2.1.1" in ignore %}
{% set rule = '(4.2.1.1) Ensure rsyslog is installed' %}
{{ rule }}:
  pkg.installed:
    - name: rsyslog
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.1.2" in ignore %}
{% set rule = '(4.2.1.2) Ensure rsyslog is enabled' %}
{{rule}}:
  service.enabled:
    - name: rsyslog
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.1.3" in ignore %}
{% set rule = '(4.2.1.3) Ensure journald is configured to send logs to rsyslog' %}
{{ rule }}:
  file.replace:
    - name: /etc/systemd/journald.conf
    - pattern: "^ForwardToSyslog.*"
    - repl: ForwardToSyslog={{ salt['pillar.get']('cis_rocky9:default:journald:forward_to_syslog', 'no') }}
    - append_if_not_found: True 

{{rule}} - rsyslog service:
  service.running:
    - name: rsyslog
    - watch:
      - file: {{rule}}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.1.4" in ignore %}
{% set rule = '(4.2.1.4) Ensure rsyslog default file permissions are configured' %}
{{ rule }}:
  file.replace:
    - name: /etc/rsyslog.conf
    - pattern: "^FileCreateMode.*"
    - repl: FileCreateMode="0644"
    - append_if_not_found: True 

{{rule}} - rsyslog service:
  service.running:
    - name: rsyslog
    - watch:
      - file: {{rule}}

{% endif %} # "ignore"



#-----------------------------------------------------------------------

{% if not "4.2.1.7" in ignore %}
{% set rule = '(4.2.1.7) Ensure rsyslog is not configured to receive logs from a remote client' %}
{% set ret = salt['cmd.script']('salt://{}/files/4_2_audit'.format(slspath), cwd='/opt')['stdout'] %}
{% if ret %}
{% set ret = ret|replace(':', ' ') %}
{% set ret = ret.split('\n') %}
{{rule}}:
  test.fail_without_changes:
    - name: Rsyslog configured to recieve messages from remote hosts {{ ret }}
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.2.1.1" in ignore %}
{% set rule = '(4.2.2.1.1) Ensure systemd-journal-remote is installed' %}
{{ rule }}:
  pkg.installed:
    - name: systemd-journal-remote
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.2.1.2" in ignore %}
{% set rule = '(4.2.2.1.2) Ensure systemd-journal-remote is configured' %}
{% set ret = salt['cmd.run_all'](cmd="grep -P \"^ *URL=|^ *ServerKeyFile=|^ *ServerCertificateFile=|^ *TrustedCertificateFile=\" /etc/systemd/journal-upload.conf", python_shell=True)['stdout'] %}
{% if not ret %}
{{rule}}:
  test.fail_without_changes:
    - name: Systemd-journal-remote is not configured to send logs to remote server
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.2.1.3" in ignore %}
{% set rule = '(4.2.2.1.3) Ensure systemd-journal-remote is enabled' %}
{{rule}}:
  service.enabled:
    - name: systemd-journal-upload
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.2.1.4" in ignore %}
{% set rule = '(4.2.2.1.4) Ensure journald is not configured to receive logs from a remote client' %}
{% set ret = salt['cmd.run_all'](cmd="systemctl is-enabled systemd-journal-remote.socket", python_shell=True)['stdout'] %}
{% if not ret == "masked" %}
{{rule}}:
  cmd.run:
    - name: systemctl --now mask systemd-journal-remote.socket
{% endif %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.2.2" in ignore %}
{% set rule = '(4.2.2.2) Ensure journald service is enabled' %}
{{rule}}:
  service.enabled:
    - name: systemd-journald
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.2.3" in ignore %}
{% set rule = '(4.2.2.3) Ensure journald is configured to compress large log files' %}
{{ rule }} - /etc/systemd/journald.conf:
  file.replace:
    - name: /etc/systemd/journald.conf
    - pattern: "^Compress=.*"
    - repl: Compress={{ salt['pillar.get']('cis_rocky9:default:journald:compress', 'yes') }}"
    - append_if_not_found: True

{{rule}} - systemd journal service:
  service.running:
    - name: systemd-journald
    - watch:
      - file: {{rule}} - /etc/systemd/journald.conf

{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "4.2.2.4" in ignore %}
{% set rule = '(4.2.2.4) Ensure journald is configured to write logfiles to persistent disk' %}
{{rule}} - /etc/systemd/journald.conf:
  file.replace:
    - name: /etc/systemd/journald.conf
    - pattern: "^Storage=.*"
    - repl: Storage={{ salt['pillar.get']('cis_rocky9:default:journald:storage', 'persistent') }}
    - append_if_not_found: True

{{rule}} - systemd journal service:
  service.running:
    - name: systemd-journald
    - watch:
      - file: {{rule}} - /etc/systemd/journald.conf

{% endif %} # "ignore"


#-----------------------------------------------------------------------

{% if not "4.2.3" in ignore %}
{% set rule = '(4.2.3)  Ensure all logfiles have appropriate permissions and ownership' %}

{% set ret = salt['cmd.script']('salt://{}/files/4_2_3_audit'.format(slspath), cwd='/opt') %}
{% if ret['stdout'] == "FAIL" %}
{{rule}}:
  cmd.script:
    - source: salt://{{ slspath }}/files/4_2_3_rem
    - cwd: /opt
{% endif %}
{% endif %} # "ignore"