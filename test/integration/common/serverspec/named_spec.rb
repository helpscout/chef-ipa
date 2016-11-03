require 'spec_helper'

describe 'named' do

  it 'has a running service of bind9-pkcs11' do
    expect(service('bind9-pkcs11')).to be_running
  end

  it 'is listening on :::53' do
    expect(port(53)).to be_listening.on('::')
  end

  it 'is listening on 127.0.0.1:953' do
    expect(port(953)).to be_listening.on('127.0.0.1')
  end

  it 'is listening on ::1:953' do
    expect(port(953)).to be_listening.on('::1')
  end

end
