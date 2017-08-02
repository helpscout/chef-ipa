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

include_recipe 'ipa::client_install'

ipa_installer_cmd = [ 'ipa-client-install', '-U' ]

unless node['ipa']['provisioning_user'].nil?
  ipa_installer_cmd += [ '-p', node['ipa']['provisioning_user']]
end

ipa_installer_cmd += [ '-w', node['ipa']['provisioning_pass']]

unless node['ipa']['client']['server'].nil?
  raise "FATAL: node['ipa']['domain'] must be specified when using node['ipa']['client']['server']" if node['ipa']['domain'].nil?
  ipa_installer_cmd += [ '--server', node['ipa']['client']['server']]
  ipa_installer_cmd += [ '--domain', node['ipa']['domain']]
end

if node['ipa']['client']['server']
  ipa_installer_cmd += [ '--fixed-primary' ]
end

if node['ipa']['client']['force-join']
  ipa_installer_cmd += [ '--force-join' ]
end

unless node['ipa']['client']['hostname'].nil?
  ipa_installer_cmd += [ '--hostname', node['ipa']['client']['hostname']]
end

unless node['ipa']['client']['nisdomain'].nil?
  ipa_installer_cmd += [ '--nisdomain', node['ipa']['client']['nisdomain']]
end

if node['ipa']['client']['mkhomedir']
  ipa_installer_cmd += [ '--mkhomedir' ]
end

unless node['ipa']['client']['ntp']
  ipa_installer_cmd += [ '--no-ntp' ]
end

unless node['ipa']['client']['sudo']
  ipa_installer_cmd += [ '--no-sudo' ]
end

if node['ipa']['client']['request-cert']
  ipa_installer_cmd += [ '--request-cert' ]
end

execute 'join realm' do
  command ipa_installer_cmd
  creates '/etc/ipa/default.conf'
end

include_recipe 'ipa::workarounds'
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
