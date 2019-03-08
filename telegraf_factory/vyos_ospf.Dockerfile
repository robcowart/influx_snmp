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

FROM robcowart/telegraf-snmp:0.0.1_vyos_base

ARG BUILD_DATE

LABEL org.opencontainers.image.created="$BUILD_DATE" \
      org.opencontainers.image.authors="elastiflow@gmail.com" \
      org.opencontainers.image.url="https://hub.docker.com/r/robcowart/telegraf-snmp" \
      org.opencontainers.image.documentation="https://github.com/robcowart/influx_snmp/README.md" \
      org.opencontainers.image.source="https://github.com/robcowart/influx_snmp" \
      org.opencontainers.image.version="0.0.1_vyos_ospf" \
      org.opencontainers.image.vendor="Robert Cowart" \
      org.opencontainers.image.title="telegraf-snmp" \
      org.opencontainers.image.description="A telegraf container to collect SNMP metrics from VyOS-based devices, incl. objects from OSPF-MIB." \
      org.opencontainers.image.licenses="MIT"

WORKDIR /etc/telegraf/telegraf.d
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfGeneralGroup.toml.conf ./
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfAreaEntry.toml.conf ./
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfLsdbEntry.toml.conf ./
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfIfEntry.toml.conf ./
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfIfMetricEntry.toml.conf ./
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfNbrEntry.toml.conf ./
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfExtLsdbEntry.toml.conf ./
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfAsLsdbEntry.toml.conf ./
COPY ./assets/oids/ietf/OSPF-MIB/OSPF-MIB_ospfAreaLsaCountEntry.toml.conf ./

ENTRYPOINT ["/entrypoint.sh"]
CMD telegraf --config /etc/telegraf/telegraf.conf --config-directory /etc/telegraf/telegraf.d
