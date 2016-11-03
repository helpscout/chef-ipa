require 'spec_helper'

describe 'kdc' do

  it 'has a running service of krb5-kdc' do
    expect(service('krb5-kdc')).to be_running
  end

  it 'is listening on 0.0.0.0:88 with tcp' do
    expect(port(88)).to be_listening.on('0.0.0.0').with('tcp')
  end

  it 'is listening on :::88 with tcp6' do
    expect(port(88)).to be_listening.on('::').with('tcp6')
  end

  it 'is listening on 0.0.0.0:88 with udp' do
    expect(port(88)).to be_listening.on('0.0.0.0').with('udp')
  end

  it 'is listening on :::88 with udp6' do
    expect(port(88)).to be_listening.on('::').with('udp6')
  end

end

describe 'kadmind' do

  it 'has a running service of of krb5-admin-service' do
    expect(service('krb5-admin-server')).to be_running
  end

  it 'is listening on 0.0.0.0:749 with tcp' do
    expect(port(749)).to be_listening.on('0.0.0.0').with('tcp')
  end

  it 'is listening on :::749 with tcp6' do
    expect(port(749)).to be_listening.on('::').with('tcp6')
  end

  it 'is listening on 0.0.0.0:464 with tcp' do
    expect(port(464)).to be_listening.on('0.0.0.0').with('tcp')
  end

  it 'is listening on :::464 with tcp6' do
    expect(port(464)).to be_listening.on('::').with('tcp6')
  end

  it 'is listening on 0.0.0.0:464 with udp' do
    expect(port(464)).to be_listening.on('0.0.0.0').with('udp')
  end

  it 'is listening on :::464 with udp6' do
    expect(port(464)).to be_listening.on('::').with('udp6')
  end

end
