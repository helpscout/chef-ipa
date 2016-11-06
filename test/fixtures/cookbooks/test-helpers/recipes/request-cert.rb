#
# Cookbook Name:: request-cert
# Recipe:: hostsfile-fixup
#

ipa_certificate 'testcert' do
  key_user 'vagrant'
  key_group 'vagrant'
  key_path '/tmp/priv.key'
  cert_path '/tmp/cert.key'
end
