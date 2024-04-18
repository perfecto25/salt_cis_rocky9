# 1.6.1.7 Ensure SETroubleshoot is not installed 

{% set rule = '(1.6.1.7)' %}


{{rule}} remove setroubleshoot pkg:
  pkg.removed:
    - name: setroubleshoot
