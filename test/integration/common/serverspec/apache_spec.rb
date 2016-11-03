require 'spec_helper'

describe 'apache' do

  it 'has a running service of apache2' do
    expect(service('apache2')).to be_running
  end

  it 'is listening on :::80' do
    expect(port(80)).to be_listening.on('::')
  end

  it 'is listening on :::443' do
    expect(port(443)).to be_listening.on('::')
  end

end
