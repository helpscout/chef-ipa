require 'timeout'

property :nickname, String, name_property: true

property :pem_ca, String
property :pem_cert, String, required: true
property :pem_key, String, required: true

property :key_size, Fixnum

property :req_subject, String
property :req_principal, String
property :req_dns, String

property :cmd_presave, String
property :cmd_postsave, String


default_action :request

action :request do
  cmd = ['ipa-getcert']
  cmd += ['request']
  cmd += ['-I', nickname ]

  # Attempt to wait until certificate has been issued
  # Only available in 16.04+
  #cmd += ['-w']

  cmd += ['-F', pem_ca] if pem_ca
  cmd += ['-f', pem_cert] if pem_cert
  cmd += ['-k', pem_key] if pem_key

  cmd += ['-g', key_size] if key_size

  cmd += ['-N', req_subject] if req_subject
  cmd += ['-K', req_principal] if req_principal

  cmd += ['-B', cmd_presave] if cmd_presave
  cmd += ['-C', cmd_postsave] if cmd_postsave

  service 'certmonger' do
    action [:enable, :start]
  end

  ruby_block 'wait on certmonger to issue certificate' do
    block do
      Timeout::timeout(30) do
        true until ::File.exists?(pem_cert)
      end
    end
    action :nothing
  end

  execute "certificate request #{nickname}" do
    command cmd
    not_if "ipa-getcert list -i #{nickname}"
    notifies :run, 'ruby_block[wait on certmonger to issue certificate]', :immediately
  end

end
