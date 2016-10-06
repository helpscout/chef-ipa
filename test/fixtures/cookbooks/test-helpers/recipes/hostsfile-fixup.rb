#
# Cookbook Name:: test-helpers
# Recipe:: hostsfile-fixup
#

template '/etc/hosts' do
  source 'hostsfile.erb'
  mode   '0655'
  owner  'root'
  group  'root'
end
