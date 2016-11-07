require 'spec_helper'

describe 'testcert-simple' do

  it 'should be a certificate' do
    expect(x509_certificate('/tmp/testcert-simple.crt')).to be_certificate
  end

  it 'should be valid' do
    expect(x509_certificate('/tmp/testcert-simple.crt')).to be_valid
  end

end
