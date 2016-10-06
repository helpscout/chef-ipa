#
# Cookbook Name:: ipa
# Attributes:: replica
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

# Replica Types
default['ipa']['replica']['ca']  = true
default['ipa']['replica']['kra'] = true
default['ipa']['replica']['dns'] = true

default['ipa']['replica']['skip-conncheck'] = false

# DNS Options
default['ipa']['replica']['dns-options']['forwarders']         = 'auto'
default['ipa']['replica']['dns-options']['reverse-zones']      = 'auto'
default['ipa']['replica']['dns-options']['dnssec-validation']  = true
default['ipa']['replica']['dns-options']['allow-zone-overlap'] = true

# Bootstrap Options
default['ipa']['replica']['bootstrap']['admin_pw'] = 'InsecureAdministratorPassword'
default['ipa']['replica']['bootstrap']['dirmn_pw'] = 'InsecureDirectoryManagerPassword'

# vim: ai ts=2 sts=2 et sw=2 ft=ruby
