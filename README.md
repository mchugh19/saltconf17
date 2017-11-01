Monitoring Reactors
===================
This is a tutorial of the monitoring setup in use by D&B in Dublin. 

Any system, service, open port, and process which is on the network and can affect the customer experience must be monitored. This creates a monitoring management problem, but salt can assist by being the interface contract between system teams and monitoring support. Salt can ensure that systems are added to monitoring and that monitoring reflects any updates applied. 

Setup
-----

 1. In the salt state applying a monitorable item to a system, have that state [add the template name to a salt grain](monitoring/templates/linux.sls)
 2. In the highstate, ensure that a [salt event is broadcast](monitoring/init.sls) on any changes to the monitoring_groups grain
 3. On the salt-master, have a reactor [listen for the monitoring change salt event](reactors/files/monitoring_groupchange.sls)
 4. The reactor launches an [orchestration job](orchestrations/monitoring_update_template.sls) which runs a [state on the zabbix server](monitoring/ensure_zabbixed.sls) which ensures the minion from the salt event exists in the zabbix monitoring server, has the appropriate IP and Zabbix proxy configuration, and has the templates defined from the monitoring_groups grain.
