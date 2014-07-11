#
# Author:: Bao Nguyen <ngqbao@gmail.com>
# Cookbook Name:: quagga
# Recipe:: default
#
# Copyright 2014, Bao Nguyen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
