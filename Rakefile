require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'

PuppetLint.configuration.fail_on_warnings
PuppetLint.configuration.send('relative')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ["spec//*.pp", "pkg//*.pp"]

PuppetSyntax.check_hiera_keys = true

task :integration => [:syntax, :lint, :metadata_lint, :spec]
