#
# Cookbook Name:: ipa
# Attributes:: default
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
case node['platform_family']
when /debian/, /fedora/
  default['ipa']['packages']['client']           = 'freeipa-client'
  default['ipa']['packages']['server']           = 'freeipa-server'
  default['ipa']['packages']['server-dns']       = 'freeipa-server-dns'
  default['ipa']['packages']['server-trust-ad']  = 'freeipa-server-trust-ad'
  default['ipa']['packages']['admintools']       = 'freeipa-admintools'
when /rhel/
  default['ipa']['packages']['client']           = 'ipa-client'
  default['ipa']['packages']['server']           = 'ipa-server'
  default['ipa']['packages']['server-dns']       = 'ipa-server-dns'
  default['ipa']['packages']['server-trust-ad']  = 'ipa-server-trust-ad'
  default['ipa']['packages']['admintools']       = 'ipa-admintools'
end

# vim: ai ts=2 sts=2 et sw=2 ft=ruby
