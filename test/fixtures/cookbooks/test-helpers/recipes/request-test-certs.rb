#
# Cookbook Name:: request-test-certs
# Recipe:: hostsfile-fixup
#
case node['platform_family']
  when 'debian'
    key_group = 'nogroup'
  when 'rhel'
    key_group = 'nobody'
end
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

ipa_certificate 'testcert-owner-test' do
  pem_key  '/tmp/testcert-owner-test.key'
  pem_key_owner 'nobody'
  pem_key_group key_group
  pem_key_mode  '0707'
  pem_cert '/tmp/testcert-owner-test.crt'
  pem_cert_owner 'nobody'
  pem_cert_group key_group
  pem_cert_mode '0707'
end
