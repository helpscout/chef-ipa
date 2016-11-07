#
# Cookbook Name:: request-test-certs
# Recipe:: hostsfile-fixup
#

ipa_certificate 'testcert-simple' do
  key_path '/tmp/testcert-simple.key'
  cert_path '/tmp/testcert-simple.crt'
end
