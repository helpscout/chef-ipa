require 'spec_helper'
require 'socket'

hostname = Socket.gethostname
fqdn = Socket.gethostbyname(Socket.gethostname).first

describe 'testcert-simple' do
  key = '/tmp/testcert-simple.key'
  cert = '/tmp/testcert-simple.crt'

  it 'should have a valid private key' do
    expect(x509_private_key(key)).to be_valid
  end

  it 'should have a certificate' do
    expect(x509_certificate(cert)).to be_certificate
  end

  it 'key and certificate should match' do
    expect(x509_private_key(key)).to have_matching_certificate(cert)
  end

  it 'should be valid' do
    expect(x509_certificate(cert)).to be_valid
  end

  it "should have the subject /O=IPA.EXAMPLE.COM/CN=#{hostname}" do
    expect(x509_certificate(cert).subject).to match "/O=IPA.EXAMPLE.COM/CN=#{hostname}"
  end
end

describe 'testcert-fqdn' do
  key = '/tmp/testcert-fqdn.key'
  cert = '/tmp/testcert-fqdn.crt'

  it 'should have a valid private key' do
    expect(x509_private_key(key)).to be_valid
  end

  it 'should have a certificate' do
    expect(x509_certificate(cert)).to be_certificate
  end

  it 'key and certificate should match' do
    expect(x509_private_key(key)).to have_matching_certificate(cert)
  end

  it 'should be valid' do
    expect(x509_certificate(cert)).to be_valid
  end

  it "should have the subject /O=IPA.EXAMPLE.COM/CN=#{fqdn}" do
    expect(x509_certificate(cert).subject).to match "/O=IPA.EXAMPLE.COM/CN=#{fqdn}"
  end
end
