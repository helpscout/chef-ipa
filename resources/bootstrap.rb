property :realm,                  String
property :admin_pw,               String, required: true
property :dirmn_pw,               String, required: true
property :dns,                    [TrueClass, FalseClass], default: true
property :dns_forwarders,         [String, Array], default: 'auto'
property :dns_reverse_zones,      [String, Array], default: 'auto'
property :dns_allow_zone_overlap, [TrueClass, FalseClass], default: true
property :dns_dnssec_validation,  [TrueClass, FalseClass], default: true
property :kra,                    [TrueClass, FalseClass], default: true

default_action :install

action :install do
  IPACookbook.replica_install(node, run_context)

  # Bootstrapping always requires a realm. If an attribute isn't set, then
  # we set the realm based on this node's domain.
  realm = new_resource.realm.nil? ? node['domain'].upcase : new_resource.realm

  # Build the installer command from our attributes
  ipa_installer_cmd = [ 'ipa-server-install', '-U' ]
  ipa_installer_cmd += [ '-r', realm]
  ipa_installer_cmd += [ '-a', new_resource.admin_pw]
  ipa_installer_cmd += [ '-p', new_resource.dirmn_pw]

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

  Chef::Log.info "XXX3 #{ipa_installer_cmd}"
  unless ::File.exists?('/etc/ipa/default.conf')
    Chef::Log.info "Bootstratpping IPA server"
    cmd = Mixlib::ShellOut.new(ipa_installer_cmd)
    cmd.run_command
    cmd.error!
  end

  if new_resource.kra && !::File.exists?('/var/lib/pki/pki-tomcat/kra')
    Chef::Log.info "Bootstratpping IPA server"
    cmd = Mixlib::ShellOut.new([ 'ipa-kra-install', '-p', new_resource.dirmn_pw])
    cmd.run_command
    cmd.error!
  end
  
  IPACookbook.workarounds(node)
end
