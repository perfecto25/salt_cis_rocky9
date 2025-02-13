### SOFTWARE UPDATES
{% set ignore = salt['pillar.get']("cis_rocky9:ignore:rules") %}


{% if not "1.2.1" in ignore %}
{% set rule = '(1.2.1) Ensure GPG keys are configured' %}
{% set repos = salt['pkg.list_repos'] %}
{% for repo, data in repos().items() %}
{{ rule }} - {{repo}}:
  pkgrepo.managed:
    - name: {{repo}}
    - humanname: {{data['name']}}
    - gpgcheck: 1
    - enabled: {{data['enabled']}}
{% endfor %}
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.2.2" in ignore %}
{% set rule = '(1.2.2) Ensure gpgcheck is globally activated' %}
{{ rule }}:
  ini.options_present:
    - name: /etc/dnf/dnf.conf
    - separator: '='
    - sections:
        main:
          gpgcheck: 1
{% endif %} # "ignore"

#-----------------------------------------------------------------------

{% if not "1.2.4" in ignore %}
{% set rule = '(1.2.4) Ensure repo_gpgcheck is globally activated' %}
{% if grains.os != "RedHat" %}
# disabled for Redhat https://access.redhat.com/solutions/7019126
{{ rule }}:
  ini.options_present:
    - name: /etc/dnf/dnf.conf
    - separator: '='
    - sections:
        main:
          repo_gpgcheck: 1
{% endif %}
{% endif %} # "ignore"
