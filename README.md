[![Build Status](https://travis-ci.org/gutocarvalho/puppet-puppetserver.svg?branch=master)](https://travis-ci.org/gutocarvalho/puppet-puppetserver)  ![License](https://img.shields.io/badge/license-Apache%202-blue.svg) ![Version](https://img.shields.io/puppetforge/v/gutocarvalho/puppetserver.svg) ![Downloads](https://img.shields.io/puppetforge/dt/gutocarvalho/puppetserver.svg)

# Puppetserver

#### Table of contents

1. [Overview](#overview)
3. [Supported Platforms](#supported-platforms)
4. [Requirements](#requirements)
5. [Installation](#installation)
6. [Usage](#usage)
7. [References](#references)
8. [Development](#development)

## Overview

This module will install the latest puppetserver in your system.

This module can also configure puppetdb integration.

This is a very simple module, usually used for development and test purposes.

Yes, you can use it in production, but it is a simple module, you may miss some parameters for production use.

The main objective is to install puppetserver with minimal intervention in the default files.

Augeas resource type is used to change parameters inside the puppet.conf.

## Supported Platforms

This module was tested under these platforms

- CentOS 6 and 7
- Debian 7 and 8
- Ubuntu 14.04 and 16.04

Tested only in X86_64 arch.  

## Requirements

### Pre-Reqs

You need internet to install packages.

You should configure your hostname properly.

You should configure your /etc/hosts properly.

    ip fqdn alias puppet

### Requirements

- Puppet >= 4.10
- Hiera >= 5

Unfortunately I intent to use Hiera v5 from start, so, yes, Hiera v3 is not compatible with this module.

#### Upgrade your Puppet Agent

Upgrade your puppet agent to >= 4.10, this is necessary to use Hiera v5 features.

RedHat Family

    # yum install puppet-agent

Debian Family

    # apt-get update
    # apt-get install puppet-agent

You need the PC1 repo configured to install puppet-agent.

#### Upgrade your Hiera config

You need to upgrade your hiera config, even with Puppet >= 4.10.

    /etc/puppetlabs/puppet/hiera.yaml

See the example bellow and upgrade your hiera config.

```
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "Per-node data (yaml version)"
    path: "nodes/%{trusted.certname}.yaml" # Add file extension.

  - name: "Other YAML hierarchy levels"
    paths:
      - "os/%{facts.os.family}.yaml"
      - "common.yaml"
```

After that, you can use this module without problems.

## Installation

via git

    # cd /etc/puppetlabs/code/environment/production/modules
    # git clone https://github.com/gutocarvalho/puppet-puppetserver.git puppetserver

via puppet

    # puppet module install gutocarvalho/puppetserver

via puppetfile

    mod 'gutocarvalho-puppetserver', '1.0.10'

## Usage

### Quick run

    puppet apply -e "include puppetserver"

### Using with parameters

#### Example in EL 7

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1.el7',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.2-1.el7',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1.el7'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => 8081,
  system_config_path => '/etc/sysconfig'
}
```

#### Example in EL 6

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1.el6',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.2-1.el6',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1.el6'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => 8081,
  system_config_path => '/etc/sysconfig'
}
```

#### Example in Ubuntu 14.04

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.2-1trusty',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => 8081,
  system_config_path => '/etc/default'
}
```

#### Example in Ubuntu 16.04

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.2-1xenial',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => 8081,
  system_config_path => '/etc/default'
}
```

#### Example in Debian 7

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.2-1wheezy',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => 8081,
  system_config_path => '/etc/default'
}
```

#### Example in Debian 8

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.2-1jessie',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => 8081,
  system_config_path => '/etc/default'
}
```

## References

### Classes

```
puppetserver
puppetserver::install (private)
puppetserver::config (private)
puppetserver::service (private)
```

### Parameters type

#### `certname`

Type: String

#### `version`

Type: String

#### `autosign`

Type: Boolean

#### `java_args`

Type: String

#### `agent_version`

Type: String

#### `puppetdb`

Type: Boolean

#### `puppetdb_version`

Type: String

#### `puppetdb_server`

Type: String

#### `puppetdb_port`

Type: Integer

#### `system_config_path`

Type: String

### Hiera Keys

```
puppetserver::puppetdb: false
puppetserver::puppetdb_server: "%{::ipaddress}"
puppetserver::puppetdb_port: 8081
puppetserver::puppetdb_version: '4.4.0-1.el7'

puppetserver::certname: "%{trusted.certname}"
puppetserver::version: '2.7.2-1.el7'
puppetserver::autosign: false
puppetserver::java_args: '-Xms2g -Xmx2 -XX:MaxPermSize=256m'
puppetserver::system_config_path: '/etc/sysconfig'

puppetserver::agent_version: '1.10.1-1.el7'
```

### Hiera module config

This is the Hiera v5 configuration inside the module.

This module does not have params class, everything is under hiera v5.

```
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "OSes"
    paths:
     - "oses/distro/%{facts.os.name}/%{facts.os.release.major}.yaml"
     - "oses/family/%{facts.os.family}.yaml"

  - name: "common"
    path: "common.yaml"

```

This is an example of files under modules/puppetserver/data

```
oses/family/RedHat.yaml
oses/family/Debian.yaml
oses/distro/CentOS/7.yaml
oses/distro/CentOS/8.yaml
oses/distro/Ubuntu/14.04.yaml
oses/distro/Ubuntu/16.04.yaml
oses/distro/Debian/7.yaml
oses/distro/Debian/8.yaml
```

## Development

### My dev envinronment

This module was developed using

- Puppet 4.10
- Hiera v5
- CentOS 7
- Vagrant 1.9
  - box: gutocarvalho/centos7x64

### Testing

This module uses puppet-lint, puppet-syntax, metadata-json-lint, rspec-puppet, beaker and travis-ci. We hope you use them before submitting your PR.

Acceptance tests (Beaker) can be executed using ./acceptance.sh. There is a matrix to test this class under Centos 6/7, Debian 7/8 and Ubuntu 14.04/16.04.

### Author/Contributors

Guto Carvalho (gutocarvalho at gmail dot com)
