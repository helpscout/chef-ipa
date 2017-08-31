#
# Cookbook Name:: ipa
# Recipe:: replica
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

ipa_replica 'replica' do
  provisioning_user      node['ipa']['provisioning_user']
  provisioning_pass      node['ipa']['provisioning_pass']
  dns                    node['ipa']['replica']['dns']
  dns_forwarders         node['ipa']['replica']['dns-options']['forwarders']
  dns_reverse_zones      node['ipa']['replica']['dns-options']['reverse-zones']
  dns_allow_zone_overlap node['ipa']['replica']['dns-options']['allow-zone-overlap']
  dns_dnssec_validation  node['ipa']['replica']['dns-options']['dnssec-validation']
  ca                     node['ipa']['replica']['ca']
  kra                    node['ipa']['replica']['kra']
  skip_conncheck         node['ipa']['replica']['skip-conncheck']
end
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
