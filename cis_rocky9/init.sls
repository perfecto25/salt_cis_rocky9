## Global Rules (can override via host-specific pillar, see sample.pillar.sls)

# include all Rules
{% if grains.os_family == "RedHat" and grains.osmajorrelease == 9 %}
include:
   - rules.1_1
   - rules.1_2
   - rules.1_3
   - rules.1_4
   - rules.1_5
   - rules.1_6
   - rules.1_7
   - rules.1_8
   - rules.1_9
   - rules.1_10
   - rules.2_1
   - rules.2_2
   - rules.2_3
   - rules.3_1
   - rules.3_2
   - rules.3_3
   - rules.3_4
   - rules.4_1
   - rules.4_2
   - rules.5_1
   - rules.5_2
   - rules.5_3
   - rules.5_4
   - rules.5_5
   - rules.5_6
   - rules.6_1
   - rules.6_2

{% endif %}
    