require 'spec_helper'
require 'socket'


# TODO: Make this a bit more DRY

hostname = Socket.gethostname
fqdn = Socket.gethostbyname(Socket.gethostname).first

describe 'testcert-simple' do
  key = '/tmp/testcert-simple.key'
  cert = '/tmp/testcert-simple.crt'

  it 'should have a valid private key' do
    expect(x509_private_key(key)).to be_valid
  end

  it 'key is owned by root' do
    expect(file(key)).to be_owned_by 'root'
  end

  it 'key is grouped into root' do
    expect(file(key)).to be_grouped_into 'root'
  end

  it 'key is mode 600' do
    expect(file(key)).to be_mode '600'
  end

  it 'should have a certificate' do
    expect(x509_certificate(cert)).to be_certificate
  end

  it 'certificate is owned by root' do
    expect(file(cert)).to be_owned_by 'root'
  end

  it 'certificate is grouped into root' do
    expect(file(cert)).to be_grouped_into 'root'
  end

  it 'cert is mode 600' do
    expect(file(cert)).to be_mode '600'
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

describe 'testcert-owner-test' do
  key = '/tmp/testcert-owner-test.key'
  cert = '/tmp/testcert-owner-test.crt'

  it 'should have a valid private key' do
    expect(x509_private_key(key)).to be_valid
  end

  it 'key is owned by nobody' do
    expect(file(key)).to be_owned_by 'nobody'
  end

  it 'key is grouped into nogroup' do
    expect(file(key)).to be_grouped_into 'nogroup'
  end

  it 'key is mode 707' do
    expect(file(key)).to be_mode '707'
  end

  it 'should have a certificate' do
    expect(x509_certificate(cert)).to be_certificate
  end

  it 'certificate is owned by nobody' do
    expect(file(cert)).to be_owned_by 'nobody'
  end

  it 'certificate is grouped into nogroup' do
    expect(file(cert)).to be_grouped_into 'nogroup'
  end

  it 'certificate is mode 707' do
    expect(file(cert)).to be_mode '707'
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

