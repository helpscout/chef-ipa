#
# Cookbook Name:: request-test-certs
# Recipe:: hostsfile-fixup
#

ipa_certificate 'testcert-simple' do
  pem_key  '/tmp/testcert-simple.key'
  pem_cert '/tmp/testcert-simple.crt'
end

ipa_certificate 'testcert-fqdn' do
  req_subject node['fqdn']
  req_principal "host/#{node['fqdn']}"
  pem_key  '/tmp/testcert-fqdn.key'
  pem_cert '/tmp/testcert-fqdn.crt'
end 
