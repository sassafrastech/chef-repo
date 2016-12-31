name             "mysql"
maintainer       "Tom Smyth"
maintainer_email "tom@sassafras.coop"
license          "MIT"
description      "Installs/configures various MySQL things"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"
depends "mysql", "~> 6.0"
depends "mysql2_chef_gem", "~> 1.1"
