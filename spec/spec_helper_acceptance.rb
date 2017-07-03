require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

#require 'beaker/puppet_install_helper'
#run_puppet_install_helper

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

RSpec.configure do |c|
  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, source: PROJECT_ROOT, module_name: 'puppetserver')
    end
  end

end
