## Global Rules (can override via host-specific pillar, see sample.pillar.sls)

# include all Rules
{% if grains.os_family == "RedHat" and grains.osmajorrelease == 9 %}
include:
   - formula.cis_rocky9.rules.1_1
   - formula.cis_rocky9.rules.1_2
   - formula.cis_rocky9.rules.1_3
   - formula.cis_rocky9.rules.1_4
   - formula.cis_rocky9.rules.1_5
   - formula.cis_rocky9.rules.1_6
   - formula.cis_rocky9.rules.1_7
   - formula.cis_rocky9.rules.1_8
   - formula.cis_rocky9.rules.1_9
   - formula.cis_rocky9.rules.1_10
   - formula.cis_rocky9.rules.2_1
   - formula.cis_rocky9.rules.2_2
   - formula.cis_rocky9.rules.2_3
   - formula.cis_rocky9.rules.3_1
   - formula.cis_rocky9.rules.3_2
   - formula.cis_rocky9.rules.3_3
   - formula.cis_rocky9.rules.3_4
   - formula.cis_rocky9.rules.4_1
   - formula.cis_rocky9.rules.4_2
   - formula.cis_rocky9.rules.5_1
   - formula.cis_rocky9.rules.5_2
   - formula.cis_rocky9.rules.5_3
   - formula.cis_rocky9.rules.5_4
   - formula.cis_rocky9.rules.5_5
   - formula.cis_rocky9.rules.5_6
   - formula.cis_rocky9.rules.6_1
   - formula.cis_rocky9.rules.6_2

{% endif %}
    