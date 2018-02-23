name              'ipa'
maintainer        'Jared Baldridge'
maintainer_email  'jrb@helpscout.com'
license           'Apache-2.0'
description       'A cookbook for managing IPA installations.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.2.4'

issues_url        'https://github.com/helpscout/chef-ipa/issues'
source_url        'https://github.com/helpscout/chef-ipa'

supports          'ubuntu', '>= 14.04'
chef_version      '>= 12.6'

# vim: ai ts=2 sts=2 et sw=2 ft=ruby
