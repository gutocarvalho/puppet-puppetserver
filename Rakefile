require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'

PuppetLint.configuration.send("disable_80chars")

task :integration => [:spec, :lint, :syntax, :metadata_lint]
