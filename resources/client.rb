
property :provisioning_user,  String
property :provisioning_pass,  String, required: true
property :server,             String
property :domain,             String
property :hostname,           String
property :nisdomain,          String
property :force_join,         [TrueClass, FalseClass], default: true
property :mkhomedir,          [TrueClass, FalseClass], default: true
property :ntp,                [TrueClass, FalseClass], default: true
property :sudo,               [TrueClass, FalseClass], default: true
property :request_cert,       [TrueClass, FalseClass], default: true
property :enable_dns_updates, [TrueClass, FalseClass], default: true

default_action :install

action :install do
  IPACookbook.client_install(node, run_context)

  ipa_installer_cmd = [ 'ipa-client-install', '-U' ]

  unless new_resource.provisioning_user.empty?
    ipa_installer_cmd += [ '-p', new_resource.provisioning_user]
  end

  ipa_installer_cmd += [ '-w', new_resource.provisioning_pass]

  if new_resource.server
    raise "FATAL: domain must be specified when using server" if new_resource.domain.empty?
    ipa_installer_cmd += [ '--server', new_resource.server]
    ipa_installer_cmd += [ '--domain', new_resource.domain]

    ipa_installer_cmd += [ '--fixed-primary' ]
  end

  if new_resource.force_join
    ipa_installer_cmd += [ '--force-join' ]
  end

  if new_resource.hostname
    ipa_installer_cmd += [ '--hostname', new_resource.hostname]
  end

  if new_resource.nisdomain
    ipa_installer_cmd += [ '--nisdomain', new_resource.nisdomain]
  end

  if new_resource.mkhomedir
    ipa_installer_cmd += [ '--mkhomedir' ]
  end

  unless new_resource.ntp
    ipa_installer_cmd += [ '--no-ntp' ]
  end

  unless new_resource.sudo
    ipa_installer_cmd += [ '--no-sudo' ]
  end

  if new_resource.request_cert
    ipa_installer_cmd += [ '--request-cert' ]
  end

  if new_resource.enable_dns_updates
    ipa_installer_cmd += [ '--enable-dns-updates' ]
  end

  Chef::Log.info "XXX3 #{ipa_installer_cmd}"
  unless ::File.exists?('/etc/ipa/default.conf')
    Chef::Log.info "Join realm"
    cmd = Mixlib::ShellOut.new(ipa_installer_cmd)
    cmd.run_command
    cmd.error!
  end

    IPACookbook.workarounds(node)
end
