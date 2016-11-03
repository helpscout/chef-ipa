require 'spec_helper'

describe 'pki' do

  it 'has a running service of pki-tomcatd' do
    expect(service('pki-tomcatd')).to be_running
  end

  it 'is listening on :::8443' do
    expect(port(8443)).to be_listening.on('::')
  end

  it 'is listening on :::8080' do
    expect(port(8080)).to be_listening.on('::')
  end

  it 'is listening on 127.0.0.1:8005' do
    expect(port(8005)).to be_listening.on('127.0.0.1')
  end

  it 'is listening on 127.0.0.1:8009' do
    expect(port(8009)).to be_listening.on('127.0.0.1')
  end

end
