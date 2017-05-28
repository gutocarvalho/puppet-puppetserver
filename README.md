[![Build Status](https://travis-ci.org/gutocarvalho/puppet-puppetserver.svg?branch=master)](https://travis-ci.org/gutocarvalho/puppet-puppetserver)

[![Test Coverage](https://codeclimate.com/github/gutocarvalho/puppet-puppetserver/badges/coverage.svg)](https://codeclimate.com/github/codeclimate/codeclimate/coverage)

[![Coverage Status](https://coveralls.io/repos/github/gutocarvalho/puppet-puppetserver/badge.svg?branch=master)](https://coveralls.io/github/gutocarvalho/puppet-puppetserver?branch=master)

## Puppetserver Module

This module will install puppetserver in your system.

This module can configure puppetdb integration.

This is a very simple module, for development and test purposes.

## Requirements

- Puppet >= 4.10
- Hiera >= 5
- CentOS 7

### Hiera 5

Upgrade your /etc/puppetlabs/puppet/hiera.yaml to Hiera v5, see the example bellow:

```
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "Per-node data (yaml version)"
    path: "nodes/%{trusted.certname}.yaml" # Add file extension.
    # Omitting datadir and data_hash to use defaults.

  - name: "Other YAML hierarchy levels"
    paths: # Can specify an array of paths instead of one.
      - "location/%{facts.whereami}/%{facts.group}.yaml"
      - "groups/%{facts.group}.yaml"
      - "os/%{facts.os.family}.yaml"
      - "common.yaml"
```

After that, you can use this module without problems.

## How to use it

### Installation

    cd /etc/puppetlabs/code/environment/production/modules
    git clone https://github.com/gutocarvalho/puppet-puppetserver.git puppetserver

### How to use (the fast way)

    puppet apply -e "include puppetserver"

### How to use with parameters

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1.el7',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.1-1.el7',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1.el7'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => '8081',
  system_config_path => '/etc/sysconfig'
}
```
### Classes

```
puppetserver
puppetserver::install (reserved)
puppetserver::config (reserved)
puppetserver::service (reserved)
```

### Hiera Keys (Sample)

```
puppetserver::puppetdb: false
puppetserver::puppetdb_server: "%{::ipaddress}"
puppetserver::puppetdb_port: "8081"
puppetserver::puppetdb_version: '4.4.0-1.el7'

puppetserver::certname: "%{trusted.certname}"
puppetserver::version: '2.7.2-1.el7'
puppetserver::autosign: false
puppetserver::java_args: '-Xms2g -Xmx2 -XX:MaxPermSize=256m'
puppetserver::system_config_path: '/etc/sysconfig'

puppetserver::agent_version: '1.10.1-1.el7'
```
