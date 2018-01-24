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

This module will install the latest puppetserver 5 series in your system.

**If you are looking into puppet 4 and puppetserver 2 please use an older version of this module.**

This module can also configure puppetdb integration.

This is a very simple module, usually used for development and test purposes.

Yes, you can use it in production, but it is a simple module, you may miss some parameters for production use.

The main objective is to install puppetserver with minimal intervention in the default files.

Augeas resource type is used to change parameters inside the puppet.conf.

## Supported Platforms

This module was tested under these platforms

- CentOS 6 and 7
- Debian 8
- Ubuntu 16.04

Tested only in X86_64 arch.  

#### Debian 8 notes

You need to enable debian jessie backports and install jdk8 before use this module.

```
echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
apt-get update
apt-get -y -t jessie-backports install "openjdk-8-jdk-headless"
```
In the future I will try to support this requirements inside the module, for now, you should do this before.

You can try my debian8 box with jdk and backport enabled.

- https://app.vagrantup.com/gutocarvalho/boxes/debian8x64

## Requirements

### Pre-Reqs

You need internet to install packages.

You should configure your hostname properly.

You should configure your /etc/hosts properly.

    ip fqdn alias puppet

### Requirements

- Puppet >= 5.0.0
- Hiera >= 3.4 (v5 format)

## Installation

via git

    # cd /etc/puppetlabs/code/environment/production/modules
    # git clone https://github.com/gutocarvalho/puppet-puppetserver.git puppetserver

via puppet

    # puppet module install gutocarvalho/puppetserver

via puppetfile

    mod 'gutocarvalho-puppetserver'

## Usage

### Quick run

    puppet apply -e "include puppetserver"

### Using with parameters

#### Example in EL 7

```
class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.1.4-1.el7',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  agent_version      => '5.3.3-1.el7',
  puppetdb           => true,
  puppetdb_version   => '5.1.3-1.el7',
  puppetdb_server    => $trusted['certname'],
  puppetdb_port      => 8081,
  system_config_path => '/etc/sysconfig'
}
```

#### Example in EL 6

```
class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.1.4-1.el6',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  agent_version      => '5.3.3-1.el6',
  puppetdb           => true,
  puppetdb_version   => '5.1.3-1.el6',
  puppetdb_server    => $trusted['certname'],
  puppetdb_port      => 8081,
  system_config_path => '/etc/sysconfig'
}
```

#### Example in Ubuntu 16.04

```
class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.1.4-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  agent_version      => '5.3.3-1xenial',
  puppetdb           => true,
  puppetdb_version   => '5.1.3-1puppetlabs1',
  puppetdb_server    => $trusted['certname'],
  puppetdb_port      => 8081,
  system_config_path => '/etc/default'
}
```

#### Example in Debian 8

```
class { 'puppetserver':
  certname           => $trusted['certname'],
  version            => '5.1.4-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
  agent_version      => '5.3.3-1jessie',
  puppetdb           => true,
  puppetdb_version   => '5.1.3-1puppetlabs1',
  puppetdb_server    => $trusted['certname'],
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

Certificate name for the agent and server.

#### `version`

Type: String

The puppet server package version. ( 5.1.4-1puppetlabs1 | installed | latest )

#### `autosign`

Type: Boolean

If true puppet server will sign every certificate request.

#### `java_args`

Type: String

Configuration for the puppetserver JVM.

#### `agent_version`

Type: String

The puppet agent package version ( 5.3.3-1.el7 | installed | latest )

#### `puppetdb`

Type: Boolean

If true it will config puppetdb integration.

#### `puppetdb_version`

Type: String

The puppetdb package version. ( 5.1.3-1puppetlabs1 | installed | latest )

#### `puppetdb_server`

Type: String

The puppetdb server address (FQDN).

#### `puppetdb_port`

Type: Integer

The puppetdb port number (8081).

#### `system_config_path`

Type: String

Path for the default OS configuration for puppetserver package.

### Hiera Keys

```
puppetserver::puppetdb: false
puppetserver::puppetdb_server: "%{::ipaddress}"
puppetserver::puppetdb_port: 8081
puppetserver::puppetdb_version: '5.1.3-1.el7'

puppetserver::certname: "%{trusted.certname}"
puppetserver::version: '5.1.4-1.el7'
puppetserver::autosign: false
puppetserver::java_args: '-Xms2g -Xmx2g -XX:MaxPermSize=256m'
puppetserver::system_config_path: '/etc/sysconfig'

puppetserver::agent_version: '5.3.3-1.el7'
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
oses/distro/CentOS/6.yaml
oses/distro/Ubuntu/16.04.yaml
oses/distro/Debian/8.yaml
```

## Development

### My dev environment

This module was developed using

- Puppet 5.3
  - Hiera 3.4 (v5 format)
  - Facter 2.5
- CentOS 7.4
- Vagrant 2.0.1
  - box: gutocarvalho/centos7x64puppet5

### Testing

This module uses puppet-lint, puppet-syntax, metadata-json-lint, rspec-puppet, beaker and travis-ci. We hope you use them before submitting your PR.

#### Installing gems

    gem install bundler --no-rdoc --no-ri
    bundle install --without development

#### Running syntax tests

    bundle exec rake syntax
    bundle exec rake lint
    bundle exec rake metadata_lint

#### Running unit tests

    bundle exec rake spec

#### Running acceptance tests

Acceptance tests (Beaker) can be executed using ./acceptance.sh. There is a matrix 1/5 to test this class under Centos 6/7, Debian 8 and Ubuntu 14.04/16.04.

    bash ./acceptance.sh

If you want a detailed output, set this before run acceptance.sh

    export BEAKER_debug=true

If you want to test a specific OS from our matrix

    BEAKER_set=centos-6-x64 bundle exec rake beaker

Our matrix values

    centos-6-x64
    centos-7-x64
    debian-8-x64
    ubuntu-1604-x64

This matrix needs vagrant (>=1.9) and virtualbox (>=5.1) to work properly, make sure that you have both of them installed.

### Author/Contributors

Guto Carvalho (gutocarvalho at gmail dot com)
