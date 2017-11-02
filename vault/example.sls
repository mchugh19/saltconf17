{% set supersecret = salt['vault.read_secret']('secret/team1/role1') %}

{# use in state/template with {{ supersecret }} standard jinja syntax #}
{# if there are multiple fields returned by vault lookup, change to {{ supersecret.username }} syntax #}
