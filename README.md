[![Build Status](https://travis-ci.org/gutocarvalho/puppet-puppetserver.svg?branch=master)](https://travis-ci.org/gutocarvalho/puppet-puppetserver) ![License](https://img.shields.io/badge/license-Apache%202-blue.svg)
[![GitHub version](https://badge.fury.io/gh/gutocarvalho%2Fpuppet-puppetserver.svg)](https://badge.fury.io/gh/gutocarvalho%22Fpuppet-puppetserver)


### Table of contents

1. Overview
2. Development information
3. OSes Supported
4. PreReq
5. Requeriments
6. How to use it




## 1. Overview

This module will install the latest puppetserver in your system.

This module can also configure puppetdb integration.

This is a very simple module, usually used for development and test purposes.

Yes, you can use it in production, but it is a simple module, you may miss some parameters for production use.

The main objective is to install puppetserver with minimal intervention in the default files.

Augeas resource type is used to change parameters inside the puppet.conf.

## 2. Development information

This module was developed using

- Puppet 4.10.1
- Hiera 5
- CentOS 7
- Vagrant 1.9
  - box: gutocarvalho/centos7x64

## 3. OSes Supported

This module was tested under these Oses

- CentOS 6 and 7
- Debian 7 and 8
- Ubuntu 14.04 and 16.04

Tested only in X86_64 arch.  

## 4. PreReq

You need internet to install packages.

You should configure your hostname properly.

You should configure your /etc/hosts properly.

    ip fqdn alias puppet

## 5. Requirements

- Puppet >= 4.10
- Hiera >= 5

Unfortunately I intent to use Hiera v5 from start, so, yes, Hiera v3 is not compatible with this module.

### 5.1 Hiera Upgrade

You need to upgrade your hiera config, even with Puppet >= 4.10.

#### 5.1.1 Agent config: /etc/puppetlabs/puppet/hiera.yaml

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

## 6. How to use it

### 6.1 Installation

#### 6.1.1 Upgrade your Puppet Agent

Upgrade your puppet agent to >= 4.10, this is necessary to use Hiera v5 features.

    # yum install puppet-agent (redhat family)
    # apt-get update && apt-get install puppet-agent (debian family)

You need the PC1 repo configured to install these packages.

#### 6.1.2 Installing the module

via git

    # cd /etc/puppetlabs/code/environment/production/modules
    # git clone https://github.com/gutocarvalho/puppet-puppetserver.git puppetserver

via puppet

    # puppet module install gutocarvalho/puppetserver

### 6.2 How to use (the fast way)

    puppet apply -e "include puppetserver"

### 6.3 How to use with parameters

#### 6.3.1 Example in EL 7

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

#### 6.3.2 Example in EL 6

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1.el6',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.1-1.el6',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1.el6'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => '8081',
  system_config_path => '/etc/sysconfig'
}
```

#### 6.3.3 Example in Ubuntu 14.04

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.1-1precise',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => '8081',
  system_config_path => '/etc/sysconfig'
}
```

#### 6.3.4 Example in Ubuntu 16.04

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.1-1xenial',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => '8081',
  system_config_path => '/etc/sysconfig'
}
```

#### 6.3.5 Example in Debian 7

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.1-1wheezy',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => '8081',
  system_config_path => '/etc/sysconfig'
}
```


#### 6.3.6 Example in Debian 8

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.1-1jessie',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => '8081',
  system_config_path => '/etc/sysconfig'
}
```

### 6.4 Classes

```
puppetserver
puppetserver::install (private)
puppetserver::config (private)
puppetserver::service (private)
```

### 6.5 Parameters

#### 6.5.1 certname

Type: String

#### 6.5.2 version

Type: String

#### 6.5.3 autosign

Type: Boolean

#### 6.5.4 java_args

Type: String

#### 6.5.5 agent_version

Type: String

#### 6.6.6 puppetdb

Type: Boolean

#### 6.6.7 puppetdb_version

Type: String

#### 6.6.8 puppetdb_server

Type: String

#### 6.6.9 puppetdb_port

Type: String

#### 6.6.10 system_config_path

Type: String

### 6.7 Hiera Extra Info

#### 6.7.1 Hiera Keys

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

### 6.8 Hiera module config

This is the configuration for Hiera 5 inside the module.

This module does not have params class, everything is under hiera 5.

```
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "OSes"
    paths:
     - "oses/family/%{facts.os.family}.yaml"
     - "oses/operatingsystem/%{os.distro.id}/%{os.release.major}"

  - name: "common"
    path: "common.yaml"

# hierarchy order example
  # os/family/redhat.yaml
  # os/operatingsystem/centos/version_7.yaml
  # common.yaml

```
