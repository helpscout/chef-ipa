property :provisioning_user,      String
property :provisioning_pass,      String, required: true
property :server,                 String
property :domain,                 String
property :dns,                    [TrueClass, FalseClass], default: true
property :dns_forwarders,         [String, Array], default: 'auto'
property :dns_reverse_zones,      [String, Array], default: 'auto'
property :dns_allow_zone_overlap, [TrueClass, FalseClass], default: true
property :dns_dnssec_validation,  [TrueClass, FalseClass], default: true
property :ca,                     [TrueClass, FalseClass], default: true
property :kra,                    [TrueClass, FalseClass], default: true
property :skip_conncheck,         [TrueClass, FalseClass], default: false

default_action :install

action :install do
  IPACookbook.replica_install(node, run_context)

  # Build the installer command from our attributes
  ipa_installer_cmd = [ 'ipa-replica-install', '-U' ]

  unless new_resource.provisioning_user.empty?
    ipa_installer_cmd += [ '-P', new_resource.provisioning_user]
  end

  ipa_installer_cmd += [ '-p', new_resource.provisioning_pass]

  if new_resource.server
    ipa_installer_cmd += [ '--server', new_resource.server]
  end

  if new_resource.domain
    ipa_installer_cmd += ['--domain', new_resource.domain]
  end

  if new_resource.ca
    ipa_installer_cmd += ['--setup-ca']
  end

  if new_resource.kra
    ipa_installer_cmd += ['--setup-kra']
  end

  # DNS related options
  if new_resource.dns
    ipa_installer_cmd += ['--setup-dns']

    case new_resource.dns_forwarders
    when 'none'
      ipa_installer_cmd += ['--no-forwarders']
    when 'auto'
      ipa_installer_cmd += ['--auto-forwarders']
    else
      new_resource.dns_forwarders.each do |forwarder|
        ipa_installer_cmd += ['--forwarder', forwarder ]
      end
    end

    case new_resource.dns_reverse_zones
    when 'none'
      ipa_installer_cmd += ['--no-reverse']
    when 'auto'
      ipa_installer_cmd += ['--auto-reverse']
    else
      new_resource.dns_reverse_zones.each do |zone|
        ipa_installer_cmd += ['--reverse-zone', zone ]
      end
    end

    if new_resource.dns_allow_zone_overlap
      ipa_installer_cmd += ['--allow-zone-overlap']
    end

    unless new_resource.dns_dnssec_validation
      ipa_installer_cmd += ['--no-dnssec-validation']
    end
  end

  if new_resource.skip_conncheck
    ipa_installer_cmd += ['--skip-conncheck']
  end

  unless ::File.exists?('/etc/ipa/default.conf')
    Chef::Log.info "Bootstratpping IPA server"
    cmd = Mixlib::ShellOut.new(ipa_installer_cmd)
    cmd.run_command
    cmd.error!
  end
  
  IPACookbook.workarounds(node)
end
