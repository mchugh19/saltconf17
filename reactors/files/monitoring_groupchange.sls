zabbix_update_host_templates:
  runner.state.orchestrate:
    - kwarg:
        mods: orchestrations.monitoring_update_template
        pillar:
          event_data: {{ data | json() }}
