require 'mixlib/shellout'

module IPACookbook
  def self.replica_install(node, run_context)
    pkg = Chef::Resource::Package.new(node['ipa']['packages']['server'], run_context)
    pkg.run_action :install

    if node['ipa']['replica']['dns']
      pkg = Chef::Resource::Package.new(node['ipa']['packages']['server-dns'], run_context)
      pkg.run_action :install
    end
  end
  
  def self.workarounds(node)
    if node['platform'] == 'ubuntu' || node['debian']
      # Enable Home Directory Creation
      if  node['ipa']['client']['mkhomedir']
        cmd = Mixlib::ShellOut.new('grep mkhomedir /etc/pam.d/common-session').run_command
        if cmd.stdout.empty?
          Chef::Log.info 'Enable Home Directory Creation'
          cmd = Mixlib::ShellOut.new("echo 'session optional        pam_mkhomedir.so' >> /etc/pam.d/common-session")
          cmd.run_command
        end
      end

      # Enable SSSD sudo support
      if node['ipa']['client']['sudo']
        cmd = Mixlib::ShellOut.new('grep -e \'^services = .*sudo\' /etc/sssd/sssd.conf').run_command
        if cmd.stdout.empty?
          Chef::Log.info 'Enable SSSD sudo support'
          cmd = Mixlib::ShellOut.new("sed -i -e 's/^services =.*$/services = nss, sudo, pam, ssh/g' /etc/sssd/sssd.conf")
          cmd.run_command
        end
      end
      
      # Enable SSH CA Path'
      cmd = Mixlib::ShellOut.new('grep ca_db /etc/sssd/sssd.conf').run_command
      if cmd.stdout.empty?
        Chef::Log.info 'Enable SSH CA Path'
        cmd = Mixlib::ShellOut.new('sed -i -e "s|\(\[ssh\]\)|\1\nca_db = /etc/ipa/nssdb|" /etc/sssd/sssd.conf')
        cmd.run_command
      end
      
    end      
  end

  def self.client_install(node, run_context)
    pkg = Chef::Resource::Package.new(node['ipa']['packages']['client'], run_context)
    pkg.run_action :install
  end
end
