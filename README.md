# CIS Benchmark Rocky 9 Linux (v1.0.0) 12/13/2022
---

Rocky 9 CIS benchmark checks and remediation using Saltstack configuration management.

All rules are based on the CIS Rocky 9 Benchmark v1.0.0

To check your hosts for CIS compliance, run this State on your end points and pass the flag test=true. If test=true is omitted, this formula will attempt to remediate any inconsistent results it finds. CIS benchmark does its best to remediate basic things like file permissions, process and service control and user management. On other rules it will just issue a warning if something is not compliant.

CIS formula cannot remediate automatically:

- mounting of separate partitions like /home (too many variables, ie size and FS type of mount, etc, this needs to be done manually by the sysadmin)
- missing user home directories
- missing passwords
- duplicate group or user IDs

## To check a host for CIS compliance

    salt [target] state.sls cis_rocky9 test=true

## To check a host for a specific CIS ruleset only

    salt [target] state.sls cis_rocky9.rules.1_1 (check only sections 1.1)

## Skip a Rule,
to skip a specific Rule + remediation for a specific rule for all hosts, add a pillar value under cis_rocky9 (see sample.pillar.sls)

    cis_rocky9:
      ignore:
        rules: # ignore these rules
          - 1.1.1       # disable unused file systems

## Skip a section for all hosts

to skip an entire section, comment out the section in init.sls, ie

    # include all Rules
    {% if grains.os_family == "RedHat" and grains.osmajorrelease == 9 %}
    include:
      - formula.cis_rocky9.rules.1_1
      - formula.cis_rocky9.rules.1_2
      # - formula.cis_rocky9.rules.1_3
      - formula.cis_rocky9.rules.1_4
      #- formula.cis_rocky9.rules.1_5

## Ignore Rules, Package or Service checks on a per-host basis

to remove a service, package, filesystem or protocol from CIS check/compliance, or to skip a specific Rule check on an individual host, add a pillar to the minion,

```
  cis_rocky9:
    ignore:
      rules: ['1.4.2', '2.1.1.4']
      services: ['smb', 'nfs']
      packages: ['samba', 'httpd']
      filesystems: ['squashfs']
      protocols: ['rds']
```

by default, CIS state will apply the benchmark-recommended value settings for each check, for example 

    # Rule 4.1.1.2 Ensure system is disabled when audit logs are full
    admin_space_left_action = {{ salt['pillar.get']('cis_rocky9:default:auditd:admin_space_left_action', 'halt') }}"

it will apply the default 'halt' for admin_space_left_action parameter in /etc/audit/auditd.conf.

to specify a per-host value for these settings, add a pillar for the host

```
  cis_rocky9:
    default:
      auditd:
        admin_space_left_action: SUSPEND
```

To see the full list of parameters that can be provided via pillar, see 'sample.pillar.sls'

