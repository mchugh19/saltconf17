{#
 # Send an event on changes to the monitoring_groups grain.
 # Update the mine[monitoring_groups] when the monitoring_groups grain changes
 #}

Update_monitor_templates:
  event.send:
    - name: dnb/monitoring/groupchange
    - data:
      ip_address: {{ grains['fqdn_ip4'] | first | default([]) }}
      default_group: {{ salt['grains.get']('ec2_tags:SupportGroup', 'GenericSupport') }}/{{ salt['grains.get']('ec2_tags:Environment', 'Tagless') }}
      proxy: {{ salt['pillar.get']('zabbix-agent:proxy', {}) }}
    - onchanges:
      - grains: monitoring_groups


mine.update:
  module.run:
    - onchanges:
      - grains: monitoring_groups
