#
# Cookbook Name:: ipa
# Attributes:: client
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

default['ipa']['client']['server']        = nil
default['ipa']['client']['fixed-primary'] = false
default['ipa']['client']['force-join']    = false

default['ipa']['client']['hostname']      = nil
default['ipa']['client']['nisdomain']     = nil

default['ipa']['client']['mkhomedir']     = true
default['ipa']['client']['ntp']           = true
default['ipa']['client']['sudo']          = true
default['ipa']['client']['request-cert']  = false

default['ipa']['client']['domain'] = nil
default['ipa']['client']['force-ntpd'] = false
# vim: ai ts=2 sts=2 et sw=2 ft=ruby
