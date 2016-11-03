require 'spec_helper'

describe 'memcached' do

  it 'has a running service of memcached' do
    expect(service('apache2')).to be_running
  end

  it 'is listening on 127.0.0.1:11211' do
    expect(port(11211)).to be_listening.on('127.0.0.1')
  end

end
