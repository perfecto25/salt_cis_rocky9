{% set rule = '(1.6.1.7) Ensure SETroubleshoot is not installed ' %}


{{rule}}:
  pkg.removed:
    - name: setroubleshoot
