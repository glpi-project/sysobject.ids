
# sysobject.ids

This repository handles the [GLPI Agent](https://github.com/glpi-project/glpi-agent/) `sysobject.ids` file database.

The `sysobject.ids` file database is a text-based file firstly intended to help to
identify network products based on their exposed SNMP values.

# Documentation

The `sysobject.ids` file format is documented in [GLPI Agent IDS Databases documentation](https://glpi-agent.readthedocs.io/en/latest/database.html).

# Contribution

Feel free to open an [issue](https://github.com/glpi-project/sysobject.ids/issues) if you have any product supporting SNMP and you want to be discovered and inventoried by [GLPI Agent](https://github.com/glpi-project/glpi-agent) NetDiscovery and NetInventory tasks.

The `sysobject.ids` file is a text database mapping the SysObjectID snmp variable (`.1.3.6.1.2.1.1.2`) with manufacturer, type and model. It may also map to dedicated external module which can help to handle more complex case.

You can help populating the database by providing the output of following command (if available under linux, or any snmp walk more complete output):
```
# snmpget -v2c -c public "serverIP" 1.3.6.1.2.1.1.2.0
```

The following one, from a computer with [GLPI Agent](https://github.com/glpi-project/glpi-agent) installed, can also quickly help us:
```
# glpi-netinventory --credentials version:2c,community:public --debug --host "serverIP"
```

As with the SysObjectID snmp variable content, you should provide the device related and expected manufacturer, type and model strings.

The device type can be one of the following types:
* NETWORKING
* PRINTER
* STORAGE

The following types could be set but are not supported on server-side, so they should not be used:
* COMPUTER
* POWER
* PHONE
* VIDEO
* KVM

In the case you want to fix a model or a manufacturer which seems wrongly set to you, please justify your request as sometime manufacturer uses a generic sysObjectID OID.
In that case, you may also want to open a [GLPI Agent issue](https://github.com/glpi-project/glpi-agent/issues) to request we add a better support for such generic OID with a dedicated MIBSupport plugin.

You can also open a [pull request](https://github.com/glpi-project/sysobject.ids/pulls) after you have manually updated yourself your sysobject.ids file.
When editing manually sysobject.ids file, always use tabulation as field separator or your entry won't even be read as expected.
Before submitting, also check to add the entry at the right place to keep a numerically ordered list of supported OIDs.

# Release

As [GLPI Agent](https://github.com/glpi-project/glpi-agent/releases) would be released we will tag the incorporated `sysobject.ids` file starting with 1.0.

# Manual update

You can manually update `sysobject.ids` file into the installed `glpi-agent/share` folder. You just have to [download it](https://github.com/glpi-project/sysobject.ids/raw/master/sysobject.ids),
but do that at your own risk and always make a backup before updating manually.
