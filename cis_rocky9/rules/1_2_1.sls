# 1.2.1 - Ensure GPG keys are configured

{% set rule = '(1.2.1)' %}
{% set repos = salt['pkg.list_repos'] %}
{% for repo, data in repos().items() %}
{{repo}}:
  pkgrepo.managed:
    - humanname: {{data['name']}}
    - gpgcheck: 1
    - enabled: {{data['enabled']}}
{% endfor %}