Description
===========

This cookbook provide an interface via Provider to serveral Quagga daemons. It's written with
the intention of deploying Quagga on Cumulus OS running on compatible [1] OEM switches.

It's currently supporting the following daemons:

Zebra (interfaces)
OSPF
BGP

[1] http://cumulusnetworks.com/support/linux-hardware-compatibility-list/

Requirements
============

Linux

Attributes
==========

See below

Usage
=====

## BGP example

```ruby
include_recipe "quagga"

node.set[:quagga][:daemons][:bgpd] = true
node.set[:quagga][:loopback]="10.51.239.1"
node.set[:quagga][:bgp][:local_asn]="65024"
node.set[:quagga][:bgp][:ebgp_peers]={
  "65022" => {
    "ip" => ["10.101.8.69","10.101.16.69"]
  }
}
node.set[:quagga][:bgp][:networks]=["10.51.0.0/16"]

quagga_bgp "65024" do
  ebgp_peers node.quagga.bgp.ebgp_peers
  networks node.quagga.bgp.networks
  loopback node.quagga.loopback
end
```

## OSPF example

```ruby
include_recipe "quagga"

node.set[:quagga][:ospf][:area] = "0.0.0.0"
node.set[:quagga][:loopback]="127.0.0.1"
node.set[:quagga][:networks]=["10.0.0.0/16"]
node.set[:quagga][:ptp_interfaces]=["swp21"]
node.set[:quagga][:passive_interfaces]=["eth0"]

quagga_ospf "#{node.quagga.ospf.area}" do
  loopback node.quagga.loopback
  networks node.quagga.networks
end
```

Author and License
===================

__Author__ Bao Nguyen <opensource-cookbooks@ooyala.com>

Copyright 2014, Ooyala Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
