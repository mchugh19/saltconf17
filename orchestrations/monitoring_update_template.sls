{%- set data = salt.pillar.get('event_data') %}

{# Queries salt mine for monitoring_groups values for specified host #}
{%- set monitoring_groups = salt.saltutil.runner('mine.get',
    tgt=data['id'],
    fun='monitoring_groups',
    tgt_type='list')[data['id']] %}

zabbix_ensure_in_zabbix:
  salt.state:
    - tgt: "G@ec2_roles:ZabbixServer"
    - tgt_type: compound
    - concurrent: True
    - sls: monitoring.ensure_zabbixed
    - pillar:
        groups: {{ data['data']['default_group'] }}
        host: {{ data['id'] }}
        ip: {{ data['data']['ip_address'] }}
        templates: {{ monitoring_groups }}
        proxy: {{ data['data']['proxy'] }}
