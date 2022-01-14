# THIS REPOSITORY IS ARCHIVED AND SHOULD NOT BE USED!!!

## While Telegraf's SNMP input has some advantages over other open source options, the simple fact is that it has serious deficiencies that make it almost useless for anything beyond the simplest low-scale use-cases. If I ever find an SNMP poller worth recommending I will note it here at that time.

# SNMP Data Collection and Analytics with the TICK Stack
`influx_snmp` provides a solution for SNMP data collection and analytics using InfluxData's TICK Stack - Telegraf, InfluxDB, Chronograf and Kapacitor.

![influx_snmp](https://user-images.githubusercontent.com/10326954/54396081-11e73980-46b2-11e9-894c-0ca229ad3d8b.png)

## "Dockerized" Telegraf for SNMP Polling
To poll a device, a container of the appropriate type is configured and run. docker-compose provides a mechanism to easily configure and start multiple containers for the various devices in your infrastructure. An example `docker-compose.yml` file is provided, including an example of using a environment variable file to set global settings.

The containers are available on Docker Hub [HERE](https://hub.docker.com/r/robcowart/telegraf-snmp).

The following is an example `docker-compoase.yml` file, which polls three different device type-specific containers:

```
version: '3'
services:
  snmp-rt1:
    image: robcowart/telegraf-snmp:0.0.1_ubiquiti_edgeos_base
    container_name: snmp-rt1
    restart: unless-stopped
    hostname: snmp-rt1
    network_mode: host
    env_file:
      - influx_snmp.env
    environment:
      TELEGRAF_SNMP_AGENT: "192.0.2.1:161"
      TELEGRAF_SNMP_AGENT_TYPE: ubiquiti_edgeos
      TELEGRAF_SNMP_HOST: rt1

  snmp-sw1:
    image: robcowart/telegraf-snmp:0.0.1_juniper_ex
    container_name: snmp-sw1
    restart: unless-stopped
    hostname: snmp-sw1
    network_mode: host
    env_file:
      - influx_snmp.env
    environment:
      TELEGRAF_SNMP_AGENT: "192.0.2.2:161"
      TELEGRAF_SNMP_AGENT_TYPE: juniper_ex
      TELEGRAF_SNMP_HOST: rt2

  snmp-wlan1:
    image: robcowart/telegraf-snmp:0.0.1_engenius_wifi
    container_name: snmp-wlan1
    restart: unless-stopped
    hostname: snmp-wlan1
    network_mode: host
    env_file:
      - influx_snmp.env
    environment:
      TELEGRAF_SNMP_AGENT: "192.0.2.5:161"
      TELEGRAF_SNMP_AGENT_TYPE: engenius_wifi
      TELEGRAF_SNMP_HOST: wlan1
```

The external environment variable file `influx_snmp.env` for _global_ settings:

```
# The SNMP query timeout.
TELEGRAF_SNMP_TIMEOUT=5s

# polling interval.
TELEGRAF_SNMP_INTERVAL=60s

# SNMPv1/v2c community string
TELEGRAF_SNMP_COMMUNITY=public

# SNMPv3 credentials
TELEGRAF_SNMP_SEC_NAME=username
TELEGRAF_SNMP_AUTH_PROTOCOL=MD5
TELEGRAF_SNMP_AUTH_PASSWORD=changeme
TELEGRAF_SNMP_SEC_LEVEL=authNoPriv

# InfluxDB instance, credentials and DB name.
TELEGRAF_SNMP_INFLUXDB_URL=http://192.168.9.11:8086
TELEGRAF_SNMP_INFLUXDB_USER=admin
TELEGRAF_SNMP_INFLUXDB_PASSWD=changeme
TELEGRAF_SNMP_DATABASE=snmp
```

> You can also easily run InfluxDB, Kapacitor, Chronograf and even Grafana in Docker containers. A `docker-compose.yml` file to help you get started is available [HERE](https://github.com/robcowart/docker_compose_cookbook/blob/master/STACKS/influx_oss/docker-compose.yml).

## Building the Docker Containers

This repository includes the configuration and scripts to build containers for each supported device type.

## To-Do

* More Chronograf and/or Grafana Dashboards
* Kapacitor Alerts
* Additional device support
