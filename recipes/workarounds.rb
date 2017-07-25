#
# Cookbook Name:: ipa
# Recipe:: workarounds
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

case node[:platform]
# Ubuntu/Debian Workarounds
when 'ubuntu', 'debian'
# mkhomedir
  if node['ipa']['client']['mkhomedir']
    bash 'Enable Home Directory Creation' do
      code "echo 'session optional        pam_mkhomedir.so' >> /etc/pam.d/common-session"
      not_if 'grep mkhomedir /etc/pam.d/common-session'
    end
  end

# sudo
  if node['ipa']['client']['sudo']
    bash 'Enable SSSD sudo support' do
      code "sed -i -e 's/^services =.*$/services = nss, sudo, pam, ssh/g' /etc/sssd/sssd.conf"
      not_if 'grep -e \'^services = .*sudo\' /etc/sssd/sssd.conf'
    end
  end

# Kinda ugly way to ensure sssd is configured to use IPA's CA
  bash 'Enable SSH CA Path' do
    code 'sed -i -e "s|\(\[ssh\]\)|\1\nca_db = /etc/ipa/nssdb|" /etc/sssd/sssd.conf'
    not_if 'grep ca_db /etc/sssd/sssd.conf'
  end
end


# vim: ai ts=2 sts=2 et sw=2 ft=ruby
