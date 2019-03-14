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

FROM robcowart/telegraf-snmp:0.0.1_juniper_junos_base

ARG BUILD_DATE

LABEL org.opencontainers.image.created="$BUILD_DATE" \
      org.opencontainers.image.authors="elastiflow@gmail.com" \
      org.opencontainers.image.url="https://hub.docker.com/r/robcowart/telegraf-snmp" \
      org.opencontainers.image.documentation="https://github.com/robcowart/influx_snmp/README.md" \
      org.opencontainers.image.source="https://github.com/robcowart/influx_snmp" \
      org.opencontainers.image.version="0.0.1_juniper_junos_base" \
      org.opencontainers.image.vendor="Robert Cowart" \
      org.opencontainers.image.title="telegraf-snmp" \
      org.opencontainers.image.description="A telegraf container to collect SNMP metrics from Juniper SRX devices." \
      org.opencontainers.image.licenses="MIT"

##### COPY ./assets/oids/ietf/BRIDGE-MIB/BRIDGE-MIB_dot1dStpPortEntry_minimal.toml.conf ./

##### COPY ./assets/oids/ietf/Q-BRIDGE-MIB/Q-BRIDGE-MIB_dot1qPortVlanEntry_minimal.toml.conf ./

##### COPY ./assets/oids/juniper/JUNIPER-MIB/JUNIPER-MIB_jnxOperatingEntry_121210.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-FIREWALL-MIB/JUNIPER-FIREWALL-MIB_jnxFirewallsEntry.toml.conf ./
##### COPY ./assets/oids/juniper/JUNIPER-FIREWALL-MIB/JUNIPER-FIREWALL-MIB_jnxFirewallCounterEntry.toml.conf ./
# Placeholder for MPLS-MIB (090223).mib
#COPY ./assets/oids/juniper/JUNIPER-IPv6-MIB/JUNIPER-IPv6-MIB_jnxIpv6IfStatsEntry.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-COS-MIB/JUNIPER-COS-MIB_jnxCosIfqStatsEntry.toml.conf ./
##### COPY ./assets/oids/juniper/JUNIPER-COS-MIB/JUNIPER-COS-MIB_jnxCosQstatEntry_071231.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-COS-MIB/JUNIPER-COS-MIB_jnxCosInvQstatEntry.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-HOSTRESOURCES-MIB/JUNIPER-HOSTRESOURCES-MIB_jnxHrSystem.toml.conf ./
# Placeholder for JUNIPER-CHASSIS-FWDD-MIB
# Placeholder for JUNIPER-JS-IF-EXT-MIB
# Placeholder for JUNIPER-JS-AUTH-MIB
# Placeholder for JUNIPER-JS-CERT-MIB
# Placeholder for JUNIPER-JS-POLICY-MIB
# Placeholder for JUNIPER-JS-IPSEC-VPN-MIB
# Placeholder for JUNIPER-JS-NAT-MIB
# Placeholder for JUNIPER-JS-SCREENING-MIB
# Placeholder for JUNIPER-JS-IDP-MIB
# Placeholder for JUNIPER-SRX5000-SPU-MONITORING-MIB
# Placeholder for JUNIPER-JS-UTM-AV-MIB
# Placeholder for JUNIPER-LSYSSP-ZONE-MIB
# Placeholder for JUNIPER-LSYSSP-SCHEDULER-MIB
# Placeholder for JUNIPER-LSYSSP-POLICY-MIB
# Placeholder for JUNIPER-LSYSSP-POLICYWCNT-MIB
# Placeholder for JUNIPER-LSYSSP-FLOWGATE-MIB
# Placeholder for JUNIPER-LSYSSP-FLOWSESS-MIB
# Placeholder for JUNIPER-LSYSSP-NATSRCPOOL-MIB
# Placeholder for JUNIPER-LSYSSP-NATDSTPOOL-MIB
# Placeholder for JUNIPER-LSYSSP-NATSRCPATAD-MIB
# Placeholder for JUNIPER-LSYSSP-NATSRCNOPATAD-MIB
# Placeholder for JUNIPER-LSYSSP-NATSRCRULE-MIB
# Placeholder for JUNIPER-LSYSSP-NATDSTRULE-MIB
# Placeholder for JUNIPER-LSYSSP-NATSTATICRULE-MIB
# Placeholder for JUNIPER-LSYSSP-NATCONEBIND-MIB
# Placeholder for JUNIPER-LSYSSP-NATPOIPNUM-MIB
COPY ./assets/oids/juniper/JUNIPER-EX-MAC-NOTIFICATION-MIB/JUNIPER-EX-MAC-NOTIFICATION-MIB_jnxMacNotificationMIBGlobalObjects.toml.conf ./
# Placeholder for JUNIPER-PFE-MIB
#COPY ./assets/oids/juniper/JUNIPER-MIMSTP-MIB/JUNIPER-MIMSTP-MIB_jnxMIDot1sJuniperMstEntry.toml.conf ./
# Placeholder for JUNIPER-L2CP-FEATURES-MIB
# Placeholder for JUNIPER-LICENSE-MIB
# Placeholder for JUNIPER-SUBSCRIBER-MIB
# Placeholder for BFD-STD-MIB
# Placeholder for VPLS-GENERIC-DRAFT-01-MIB

COPY ./assets/oids/juniper/COMPOSED/srx_tables.toml.conf ./


ENTRYPOINT ["/entrypoint.sh"]
CMD telegraf --config /etc/telegraf/telegraf.conf --config-directory /etc/telegraf/telegraf.d
