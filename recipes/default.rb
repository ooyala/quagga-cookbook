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

package "quagga" do
  action :install
end

directory node.quagga.dir do
  owner node.quagga.user
  group node.quagga.group
  mode "0755"
  action :create
end

service "quagga" do
    action :enable
end

if node.platform == "debian"
  template "#{node.quagga.dir}/daemons" do
    source "daemons.erb"
    owner node.quagga.user
    group node.quagga.group
    mode "0644"
    notifies :restart, "service[quagga]", :delayed
  end

  template "#{node.quagga.dir}/debian.conf" do
    source "debian.conf.erb"
    owner node.quagga.user
    group node.quagga.group
    mode "0644"
  end
end

template "#{node.quagga.dir}/vtysh.conf" do
  source "vtysh.conf.erb"
  owner node.quagga.user
  group node.quagga.group
  mode "0644"
  # restart needed?
  notifies :restart, "service[quagga]", :delayed
end

service "quagga" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end
