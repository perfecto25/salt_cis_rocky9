{% set rule = '(4.1.2.3) Ensure system is disabled when audit logs are full' %}

{{ rule }} - space_left_action:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: '^space_left_action = .*'
    - repl: 'space_left_action = {{ salt['pillar.get']('cis_rocky9:default:auditd:space_left_action', 'email') }}'
    - append_if_not_found: True

{{ rule }} - action_mail_acct:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: '^action_mail_acct = .*'
    - repl: "action_mail_acct = {{ salt['pillar.get']('cis_rocky9:default:action_mail_acct', 'root') }}"
    - append_if_not_found: True

{{ rule }} - Audit admin_space_left_action:
  file.replace:
    - name: /etc/audit/auditd.conf
    - pattern: '^admin_space_left_action = .*'
    - repl: "admin_space_left_action = {{ salt['pillar.get']('cis_rocky9:default:auditd:admin_space_left_action', 'halt') }}"
    - append_if_not_found: True