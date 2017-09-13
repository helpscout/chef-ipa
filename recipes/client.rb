#
# Cookbook Name:: ipa
# Recipe:: client
#
# Author:: Jared R. Baldridge <jrb@helpscout.com>
# Copyright 2016, Help Scout
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

ipa_client "Setup IPA client" do
  provisioning_user  node['ipa']['provisioning_user']
  provisioning_pass  node['ipa']['provisioning_pass']
  server             node['ipa']['client']['server']
  domain             node['ipa']['domain']
  hostname           node['ipa']['client']['hostname']
  nisdomain          node['ipa']['client']['nisdomain']
  force_join         node['ipa']['client']['force-join']
  mkhomedir          node['ipa']['client']['mkhomedir']
  ntp                node['ipa']['client']['ntp']
  sudo               node['ipa']['client']['sudo']
  request_cert       node['ipa']['client']['request-cert']
  enable_dns_updates node['ipa']['client']['enable-dns-updates']
end
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
