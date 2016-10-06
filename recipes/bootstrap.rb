#
# Cookbook Name:: ipa
# Recipe:: replica_packages
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

include_recipe 'ipa::replica_install'

# Bootstrapping always requires a realm. If an attribute isn't set, then
# we set the realm based on this node's domain.
if node['ipa']['realm'].nil?
  realm = node['domain'].upcase
else
  realm = node['ipa']['realm']
end

# Build the installer command from our attributes
ipa_installer_cmd = [ 'ipa-server-install', '-U' ]
ipa_installer_cmd += [ '-r', realm]
ipa_installer_cmd += [ '-a', node['ipa']['replica']['bootstrap']['admin_pw']]
ipa_installer_cmd += [ '-p', node['ipa']['replica']['bootstrap']['dirmn_pw']]

# DNS related options
if node['ipa']['replica']['dns'] == true
  ipa_installer_cmd += ['--setup-dns']

  case node['ipa']['replica']['dns-options']['forwarders']
  when 'none'
    ipa_installer_cmd += ['--no-forwarders']
  when 'auto'
    ipa_installer_cmd += ['--auto-forwarders']
  else
    node['ipa']['replica']['dns-options']['forwarders'].each do |forwarder|
      ipa_installer_cmd += ['--forwarder', forwarder ]
    end
  end

  case node['ipa']['replica']['dns-options']['reverse-zones']
  when 'none'
    ipa_installer_cmd += ['--no-reverse']
  when 'auto'
    ipa_installer_cmd += ['--auto-reverse']
  else
    node['ipa']['replica']['dns-options']['reverse-zones'].each do |zone|
      ipa_installer_cmd += ['--reverse-zone', zone ]
    end
  end

  if node['ipa']['replica']['dns-options']['allow-zone-overlap'] == true
    ipa_installer_cmd += ['--allow-zone-overlap']
  end

  if node['ipa']['replica']['dns-options']['dnssec-validation'] == false
    ipa_installer_cmd += ['--no-dnssec-validation']
  end
end

execute 'bootstrap ipa instance' do
  command ipa_installer_cmd
  creates '/etc/ipa/default.conf'
end

if node['ipa']['replica']['kra'] == true
  execute 'bootstrap kra' do
    command [ 'ipa-kra-install', '-p', node['ipa']['replica']['bootstrap']['dirmn_pw']]
    creates '/var/lib/pki/pki-tomcat/kra'
  end
end
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
