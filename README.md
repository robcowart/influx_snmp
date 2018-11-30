# SNMP Data Collection and Analytics with the TICK Stack
`influx_snmp` provides a solution for SNMP data collection and analytics using the InfluxData's TICK Stack - Telegraf, InfluxDB, Chronograf and Kapacitor.

# The Cookbook
The `cookbook` directory provides configuration files for Telegraf that simplify its use for SNMP data collection.

## devices
The `devices` directory contains pre-built SNMP plugin configurations for a variety of SNMP-compatible devices.

## oids
The files in the `oids` directory contain configuration blocks for a variety of SNMP MIB objects and tables. These configuration blocks can be used to build a device-specific SNMP plugin configuration.

# Configuring Telegraf
To configure Telegraf for SNMP collection, complete the following steps:

### 1. Setup the configuration directory
Copy the provided `telegraf` directory to `/etc/telegraf`.

### 2. Set the global polling frequency
Edit `telegraf/telegraf.conf` to set a global polling frequency: `interval = "60s"`

### 3. Copy the relevant configuration files to telegraf.d
For each device that you want to poll, copy the relevant plugin configuration file from `cookbook/devices` to `telegraf.d`.

### 4. Add the device hostname to the configuration filename
It is likely that you will have more than one of a given device type. In this scenario it is recommended that a plugin configuration be setup for each device. To accomplish this each plugin configuration file will need to be uniquely named. To keep things well organized, add the device name to the file name using this convention: `input_juniper_srx.<device_hostname>.toml.conf`. For example: `input_juniper_srx.core-fw-1.toml.conf`

### 5. Edit the configuration file as required.
* Set the IP address of the device to be polled: `agents = [ "192.0.2.1:161" ]`
* Optionally configure a device-specific polling frequency: `interval = "60s"`
* Set the community string or other SNMP credentials: `community = "public"`

#### 5b. Configure the community string globally per device type
Aternatively, community strings can be configured globally per device type. This is achieved via an environment variable, e.g. `community = "$TELEGRAF_ENGENIUS_WIFI_COMMUNITY"`. A systemd configuration file is provided, `telegraf.service.d/telegraf.conf`, which allows the environment variable values to be easily set.

### 6. Start Telegraf
Start Telegraf be running the following commands:

```
$ systemctl daemon-reload
$ systemctl start telegraf.service
```

To ensure Telegraf is started automatically at system boot, run:

```
$ systemctl enable telegraf.service
```

# To-Do
* Chronograf and/or Grafana Dashboards
* Kapacitor Alerts
* Additional device support
