#
# Author:: Bao Nguyen <ngqbao@gmail.com>
# Cookbook Name:: quagga
# Provider:: ospf
#
# Copyright 2014, Ooyala
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

action :add do
  ospfd_path = "#{node.quagga.dir}/ospfd.conf"
  Chef::Log.info "Adding #{new_resource.name.to_s}: ospf to #{ospfd_path}"

  template "#{ospfd_path}" do
    cookbook "quagga"
    source "ospfd.conf.erb"
    owner node.quagga.user
    group node.quagga.group
    mode "0644"
    variables(
      :area => new_resource.name,
      :networks => new_resource.networks,
      :loopback => new_resource.loopback,
      :protocols => new_resource.protocols,
      :interfaces => new_resource.interfaces,
      :ospf_options => new_resource.ospf_options
    )
    notifies :reload, "service[quagga]", :delayed
  end

  # configure loopback
  ifconfig "#{new_resource.loopback}/32" do
    device "lo:1"
  end
end

action :remove do
  ospfd_path = "#{node.quagga.dir}/ospfd.conf"
  if ::File.exists?(ospfd_path)
    Chef::Log.info "Removing #{new_resource.file_type.to_s}: ospf from #{ospfd_path}"
    file ospfd_path do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end
