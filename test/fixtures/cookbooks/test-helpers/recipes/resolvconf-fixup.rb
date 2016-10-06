#
# Cookbook Name:: test-helpers
# Recipe:: resolvconf-fixup
#

cookbook_file '/etc/resolv.conf' do
  source 'resolv.conf'
  mode   '0655'
  owner  'root'
  group  'root'
end
