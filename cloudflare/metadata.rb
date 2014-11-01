name              'cloudflare'
maintainer        'DigitLab'
maintainer_email  'nick@digitlab.co.za'
license           'Apache 2.0'
description       'Installs and configures mod_cloudflare'
version           '0.0.1'

recipe 'cloudflare', 'Installs and configures cloudflare'

depends "apache2"

supports "ubuntu"
