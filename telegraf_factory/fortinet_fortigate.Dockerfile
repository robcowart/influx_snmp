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
      org.opencontainers.image.version="0.0.1_fortinet_fortigate" \
      org.opencontainers.image.vendor="Robert Cowart" \
      org.opencontainers.image.title="telegraf-snmp" \
      org.opencontainers.image.description="A telegraf container to collect SNMP metrics from Fortinet FortiGate devices." \
      org.opencontainers.image.licenses="MIT"

WORKDIR /etc/telegraf
COPY ./assets/telegraf.conf ./

WORKDIR /etc/telegraf/telegraf.d
COPY ./assets/telegraf.d/output_influxdb.toml.conf ./
COPY ./assets/telegraf.d/processor_20_strings.toml.conf ./

COPY ./assets/oids/ietf/SNMPv2-MIB/SNMPv2-MIB_system.toml.conf ./

COPY ./assets/oids/ietf/IF-MIB/IF-MIB_interfaces.toml.conf ./
COPY ./assets/oids/ietf/IF-MIB/IF-MIB_ifXEntry_HC_minimal.toml.conf ./
COPY ./assets/oids/ietf/IF-MIB/IF-MIB_ifMIBObjects.toml.conf ./

COPY ./assets/oids/ietf/EtherLike-MIB/EtherLike-MIB_dot3StatsEntry_fortinet_fortigate.toml.conf ./
COPY ./assets/oids/ietf/EtherLike-MIB/EtherLike-MIB_dot3ControlEntry_HC_minimal.toml.conf ./
COPY ./assets/oids/ietf/EtherLike-MIB/EtherLike-MIB_dot3PauseEntry_minimal.toml.conf ./

COPY ./assets/oids/ietf/IP-MIB/IP-MIB_ip_fortinet_fortigate.toml.conf ./
COPY ./assets/oids/ietf/IP-MIB/IP-MIB_icmp_minimal.toml.conf ./

COPY ./assets/oids/ietf/TCP-MIB/TCP-MIB_tcp_minimal.toml.conf ./

COPY ./assets/oids/ietf/UDP-MIB/UDP-MIB_udp.toml.conf ./

##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgVdInfo.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgVdEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgSystemInfo.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgProcessors.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgProcessorEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgProcessorModules.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgProcessorModuleEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgSysInfoAdvMem.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgSysInfoAdvSessions.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgFwPolStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgIntfEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgIntfVrrps.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAvStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgIpsStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgWebfilterStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgFortiGuardStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppProxyHTTP.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgApHTTPStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppProxySMTP.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgApSMTPStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppProxyPOP3.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgApPOP3StatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppProxyIMAP.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgApIMAPStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppProxyNNTP.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgApNNTPStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppProxyIM.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgApIMStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppProxySIP.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgApSIPStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppScanUnit.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppSuStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppVoIPStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppP2PStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppP2PProtoEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppIMStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgAppProxyFTP.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgApFTPStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgExplicitProxyInfo.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgIpSessStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgIp6SessStatsEntry.toml.conf ./
COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgVpnInfo.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgVpnSslStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgHaStatsEntry.toml.conf ./
##### COPY ./assets/oids/fortinet/FORTINET-FORTIGATE-MIB/fgWcInfo.toml.conf ./

COPY ./assets/oids/fortinet/COMPOSED/fortigate_base_tables.toml.conf ./


ENTRYPOINT ["/entrypoint.sh"]
CMD telegraf --config /etc/telegraf/telegraf.conf --config-directory /etc/telegraf/telegraf.d
