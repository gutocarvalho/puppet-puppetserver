[![Build Status](https://travis-ci.org/gutocarvalho/puppet-puppetserver.svg?branch=master)](https://travis-ci.org/gutocarvalho/puppet-puppetserver)  ![License](https://img.shields.io/badge/license-Apache%202-blue.svg) ![Version](https://img.shields.io/puppetforge/v/gutocarvalho/puppetserver.svg) ![Downloads](https://img.shields.io/puppetforge/dt/gutocarvalho/puppetserver.svg)

### Table of contents

1. Overview
2. Development information
3. OSes Supported
4. PreReq
5. Requeriments
6. Installation
7. Usage

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

### 5.1 Upgrade your Puppet Agent

Upgrade your puppet agent to >= 4.10, this is necessary to use Hiera v5 features.

    # yum install puppet-agent (redhat family)
    # apt-get update && apt-get install puppet-agent (debian family)

You need the PC1 repo configured to install these packages.

### 5.2 Upgrade your Hiera config

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

## 6. Installation

via git

    # cd /etc/puppetlabs/code/environment/production/modules
    # git clone https://github.com/gutocarvalho/puppet-puppetserver.git puppetserver

via puppet

    # puppet module install gutocarvalho/puppetserver

## 7. Usage

### 7.1 Quick use

    puppet apply -e "include puppetserver"

### 7.2 Using with parameters

#### 7.3.1 Example in EL 7

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

#### 7.3.2 Example in EL 6

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

#### 7.3.3 Example in Ubuntu 14.04

```
class { 'puppetserver':
  certname           => $trusted[certname],
  version            => '2.7.2-1puppetlabs1',
  autosign           => true,
  java_args          => '-Xms2g -Xmx2 -XX:MaxPermSize=256m',
  agent_version      => '1.10.1-1trusty',
  puppetdb           => true,
  puppetdb_version   => '4.4.0-1puppetlabs1'
  puppetdb_server    => $trusted[certname],
  puppetdb_port      => '8081',
  system_config_path => '/etc/sysconfig'
}
```

#### 7.3.4 Example in Ubuntu 16.04

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

#### 7.3.5 Example in Debian 7

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

#### 7.3.6 Example in Debian 8

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

### 8.4 Classes

```
puppetserver
puppetserver::install (private)
puppetserver::config (private)
puppetserver::service (private)
```

### 8.5 Parameters

#### 8.5.1 certname

Type: String

#### 8.5.2 version

Type: String

#### 8.5.3 autosign

Type: Boolean

#### 8.5.4 java_args

Type: String

#### 8.5.5 agent_version

Type: String

#### 8.6.6 puppetdb

Type: Boolean

#### 8.6.7 puppetdb_version

Type: String

#### 8.6.8 puppetdb_server

Type: String

#### 8.6.9 puppetdb_port

Type: String

#### 8.6.10 system_config_path

Type: String

### 8.7 Hiera Keys

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

### 8.8 Hiera module config

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
