{% set zab_hostgroup = pillar['groups'] %}
{% set zab_host = pillar['host'] %}
{% set zab_ip = pillar['ip'] %}
{% set zab_templates = pillar['templates'] %}
{% set zab_proxy = pillar['proxy'] %}

create_host_group:
  zabbix_hostgroup.present:
    - name: {{ zab_hostgroup }}

create_host_{{ zab_host }}:
  zabbix_host.present:
    - host: {{ zab_host }}
    {% if zab_proxy -%}
    - proxy_host: {{ zab_proxy }}
    {% endif -%}
    - groups:
      - {{ zab_hostgroup }}
    - interfaces:
      - {{ zab_host }}:
        - ip: {{ zab_ip }}
        - type: 'Agent'
        - port: 10050

add_zabbix_templates_to_host:
  zabbix_host.assign_templates:
    - host: {{ zab_host }}
    - templates: {{ zab_templates }}
