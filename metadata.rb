name 'sassafras'
maintainer 'Sassafras Tech Collective'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Stuff'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1'

chef_version '>= 12.5' if respond_to?(:chef_version)
