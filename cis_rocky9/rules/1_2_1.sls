# 1.2.1 - ensure GPG keys are configured


{% set rule = '(1.2.1)' %}


{% set result = salt['cmd.script']('salt://{}/files/1_2_1_gpgkeys'.format(slspath), cwd='/opt') %}


{% do salt.log.error(result) -%}


# {{ rule }} ensure GPG keys are configured:
#   test.show_notification:
#     - text: review these GPG keys {{ result['stdout'] }}


{% set repos = salt['pkg.list_repos'] %}

{% for repo, data in repos().items() %}
{{repo}}:
  pkgrepo.managed:
    - humanname: {{data['name']}}
    - gpgcheck: 1
    - enabled: {{data['enabled']}}
{% endfor %}