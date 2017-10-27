{#
 #  Enable OS Linux
 #  Sets grain to include the above template
 #}

enable_linux_template:
  grains.list_present:
    - name: monitoring_groups
    - value: 'Template OS Linux'
