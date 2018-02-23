require 'spec_helper'

describe 'IPA realm IPA.EXAMPLE.COM' do

  it 'has created a user named admin' do
    expect(user('admin')).to exist
  end

  it 'has created a group named admins' do
    expect(group('admins')).to exist
  end

  it 'can obtain a tgt for admin@IPA.EXAMPLE.COM' do
    expect(command('echo InsecureAdministratorPassword | kinit admin').exit_status).to equal(0)
  end

end
