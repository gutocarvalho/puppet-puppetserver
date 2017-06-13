require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

HIERA_FILE = 'hiera.yaml'

RSpec.configure do |c|
  c.before :suite do
    hosts.each do |host|
      scp_to(host, HIERA_FILE, "/etc/puppetlabs/puppet/#{HIERA_FILE}" )
      copy_module_to(host, source: PROJECT_ROOT, module_name: 'puppetserver')
    end
  end

end
