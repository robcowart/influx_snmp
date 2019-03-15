#--------------------------------------------------------------------------------------------------
# MIT License
# Copyright 2019 Robert Cowart
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
# NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#--------------------------------------------------------------------------------------------------

FROM telegraf:1.10.0-alpine

ARG BUILD_DATE

LABEL org.opencontainers.image.created="$BUILD_DATE" \
      org.opencontainers.image.authors="elastiflow@gmail.com" \
      org.opencontainers.image.url="https://hub.docker.com/r/robcowart/telegraf-snmp" \
      org.opencontainers.image.documentation="https://github.com/robcowart/influx_snmp/README.md" \
      org.opencontainers.image.source="https://github.com/robcowart/influx_snmp" \
      org.opencontainers.image.version="0.0.1_vyos_base" \
      org.opencontainers.image.vendor="Robert Cowart" \
      org.opencontainers.image.title="telegraf-snmp" \
      org.opencontainers.image.description="A telegraf container to collect SNMP metrics from VyOS-based devices." \
      org.opencontainers.image.licenses="MIT"

WORKDIR /etc/telegraf
COPY ./assets/telegraf.conf ./

WORKDIR /etc/telegraf/telegraf.d
COPY ./assets/telegraf.d/output_influxdb.toml.conf ./
COPY ./assets/telegraf.d/processor_20_strings.toml.conf ./

COPY ./assets/oids/ietf/SNMPv2-MIB/SNMPv2-MIB_system.toml.conf ./
COPY ./assets/oids/ietf/SNMPv2-MIB/SNMPv2-MIB_snmp.toml.conf ./

COPY ./assets/oids/ietf/HOST-RESOURCES-MIB/HOST-RESOURCES-MIB_hrSystem.toml.conf ./
COPY ./assets/oids/ietf/HOST-RESOURCES-MIB/HOST-RESOURCES-MIB_hrStorageEntry.toml.conf ./
COPY ./assets/oids/ietf/HOST-RESOURCES-MIB/HOST-RESOURCES-MIB_hrDeviceEntry.toml.conf ./
COPY ./assets/oids/ietf/HOST-RESOURCES-MIB/HOST-RESOURCES-MIB_hrProcessorEntry.toml.conf ./
COPY ./assets/oids/ietf/HOST-RESOURCES-MIB/HOST-RESOURCES-MIB_hrSWRunPerfEntry.toml.conf ./

COPY ./assets/oids/ietf/IF-MIB/IF-MIB_interfaces.toml.conf ./
COPY ./assets/oids/ietf/IF-MIB/IF-MIB_ifXEntry_HC.toml.conf ./
COPY ./assets/oids/ietf/IF-MIB/IF-MIB_ifMIBObjects.toml.conf ./

COPY ./assets/oids/ietf/IP-MIB/IP-MIB_ip.toml.conf ./
COPY ./assets/oids/ietf/IP-MIB/IP-MIB_ipTrafficStats.toml.conf ./
COPY ./assets/oids/ietf/IP-MIB/IP-MIB_ipSystemStatsEntry_HC.toml.conf ./
COPY ./assets/oids/ietf/IP-MIB/IP-MIB_ipIfStatsEntry_HC.toml.conf ./
COPY ./assets/oids/ietf/IP-MIB/IP-MIB_icmp.toml.conf ./
COPY ./assets/oids/ietf/IP-MIB/IP-MIB_icmpStatsEntry.toml.conf ./

COPY ./assets/oids/ietf/TCP-MIB/TCP-MIB_tcp.toml.conf ./

COPY ./assets/oids/ietf/UDP-MIB/UDP-MIB_udp.toml.conf ./

COPY ./assets/oids/net-snmp/UCD-SNMP-MIB/UCD-SNMP-MIB_memory.toml.conf ./
COPY ./assets/oids/net-snmp/UCD-SNMP-MIB/UCD-SNMP-MIB_laEntry.toml.conf ./
COPY ./assets/oids/net-snmp/UCD-SNMP-MIB/UCD-SNMP-MIB_systemStats_110514.toml.conf ./
COPY ./assets/oids/net-snmp/UCD-DISKIO-MIB/UCD-DISKIO-MIB_diskIOEntry_HC.toml.conf ./

ENTRYPOINT ["/entrypoint.sh"]
CMD telegraf --config /etc/telegraf/telegraf.conf --config-directory /etc/telegraf/telegraf.d
