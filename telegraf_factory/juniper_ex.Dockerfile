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
      org.opencontainers.image.description="A telegraf container to collect SNMP metrics from Juniper EX devices." \
      org.opencontainers.image.licenses="MIT"

##### COPY ./assets/oids/ietf/BRIDGE-MIB/BRIDGE-MIB_dot1dStpPortEntry_minimal.toml.conf ./

##### COPY ./assets/oids/ietf/Q-BRIDGE-MIB/Q-BRIDGE-MIB_dot1qPortVlanEntry_minimal.toml.conf ./

# Placeholder for MPLS-MIB
COPY ./assets/oids/juniper/JUNIPER-EX-MAC-NOTIFICATION-MIB/JUNIPER-EX-MAC-NOTIFICATION-MIB_jnxMacNotificationMIBGlobalObjects.toml.conf ./
#COPY ./assets/oids/juniper/JUNIPER-MIMSTP-MIB/JUNIPER-MIMSTP-MIB_jnxMIDot1sJuniperMstEntry.toml.conf ./
# Placeholder for BFD-STD-MIB
# Placeholder for VPLS-GENERIC-DRAFT-01-MIB

COPY ./assets/oids/juniper/COMPOSED/ex_tables.toml.conf ./


ENTRYPOINT ["/entrypoint.sh"]
CMD telegraf --config /etc/telegraf/telegraf.conf --config-directory /etc/telegraf/telegraf.d
