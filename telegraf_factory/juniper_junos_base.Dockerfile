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
      org.opencontainers.image.version="0.0.1_juniper_junos_base" \
      org.opencontainers.image.vendor="Robert Cowart" \
      org.opencontainers.image.title="telegraf-snmp" \
      org.opencontainers.image.description="A telegraf container to collect basic SNMP metrics from Juniper JUNOS devices." \
      org.opencontainers.image.licenses="MIT"

WORKDIR /etc/telegraf
COPY ./assets/telegraf.conf ./

WORKDIR /etc/telegraf/telegraf.d
COPY ./assets/telegraf.d/output_influxdb.toml.conf ./
COPY ./assets/telegraf.d/processor_20_strings.toml.conf ./

COPY ./assets/oids/ietf/SNMPv2-MIB/SNMPv2-MIB_system.toml.conf ./
##### COPY ./assets/oids/ietf/SNMPv2-MIB/SNMPv2-MIB_snmp.toml.conf ./

COPY ./assets/oids/ietf/IF-MIB/IF-MIB_interfaces.toml.conf ./
##### COPY ./assets/oids/ietf/IF-MIB/IF-MIB_ifXEntry_HC_minimal.toml.conf ./
COPY ./assets/oids/ietf/IF-MIB/IF-MIB_ifMIBObjects.toml.conf ./

##### COPY ./assets/oids/ietf/EtherLike-MIB/EtherLike-MIB_dot3StatsEntry_juniper_junos.toml.conf ./
#COPY ./assets/oids/ietf/EtherLike-MIB/EtherLike-MIB_dot3ControlEntry_minimal.toml.conf ./
#COPY ./assets/oids/ietf/EtherLike-MIB/EtherLike-MIB_dot3PauseEntry_minimal.toml.conf ./

COPY ./assets/oids/ietf/IP-MIB/IP-MIB_ip_minimal.toml.conf ./
COPY ./assets/oids/ietf/IP-MIB/IP-MIB_icmp_minimal.toml.conf ./

COPY ./assets/oids/ietf/TCP-MIB/TCP-MIB_tcp_minimal.toml.conf ./

COPY ./assets/oids/ietf/UDP-MIB/UDP-MIB_udp.toml.conf ./

#COPY ./assets/oids/ietf/BRIDGE-MIB/BRIDGE-MIB_dot1dBase.toml.conf ./

COPY ./assets/oids/ietf/HOST-RESOURCES-MIB/HOST-RESOURCES-MIB_hrSystem.toml.conf ./
##### COPY ./assets/oids/ietf/HOST-RESOURCES-MIB/HOST-RESOURCES-MIB_hrStorageEntry.toml.conf ./

##### COPY ./assets/oids/juniper/JUNIPER-MIB/JUNIPER-MIB_jnxOperatingEntry_101022.toml.conf ./
##### COPY ./assets/oids/juniper/JUNIPER-MIB/JUNIPER-MIB_jnxFruEntry_minimal.toml.conf ./
COPY ./assets/oids/juniper/JUNIPER-MIB/JUNIPER-MIB_jnxBoxAnatomy.toml.conf ./
##### COPY ./assets/oids/juniper/JUNIPER-IF-MIB/JUNIPER-IF-MIB_ifJnxEntry_021031.toml.conf ./
##### COPY ./assets/oids/juniper/JUNIPER-ALARM-MIB/JUNIPER-ALARM-MIB_jnxRedAlarms.toml.conf ./
##### COPY ./assets/oids/juniper/JUNIPER-ALARM-MIB/JUNIPER-ALARM-MIB_jnxYellowAlarms.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-IPv6-MIB/JUNIPER-IPv6-MIB_jnxIpv6GlobalStats.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-IPv6-MIB/JUNIPER-IPv6-MIB_jnxIcmpv6GlobalStats.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-COS-MIB/JUNIPER-COS-MIB_jnxCosIfqStatsEntry_minimal.toml.conf ./
##### COPY ./assets/oids/juniper/JUNIPER-COS-MIB/JUNIPER-COS-MIB_jnxCosQstatEntry_minimal.toml.conf ./
##### COPY ./assets/oids/juniper/JUNIPER-VPN-MIB/JUNIPER-VPN-MIB_jnxVpnInfo.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-HOSTRESOURCES-MIB/JUNIPER-HOSTRESOURCES-MIB_jnxHrStorageEntry.toml.conf ./

COPY ./assets/oids/juniper/COMPOSED/junos_base_tables.toml.conf ./


ENTRYPOINT ["/entrypoint.sh"]
CMD telegraf --config /etc/telegraf/telegraf.conf --config-directory /etc/telegraf/telegraf.d
