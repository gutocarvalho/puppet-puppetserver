# docs
class puppetserver::config {

  augeas {'main_certname':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set main/certname ${puppetserver::certname}", ],
  }

  augeas {'main_server':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set main/server ${puppetserver::certname}", ],
  }

  augeas {'java_args':
    context => "${puppetserver::system_config_path}/puppetserver",
    changes => [ "set JAVA_ARGS '\"${puppetserver::java_args}\"'", ],
    notify  => Service['puppetserver']
  }

  if $puppetserver::autosign {
    augeas {'master_autosign':
      context => '/files/etc/puppetlabs/puppet/puppet.conf/master',
      changes => [
        'set autosign true',
      ],
      notify  => Service['puppetserver']
    }
  }

  if $puppetserver::puppetdb {
    augeas {'master_storeconfigs':
      context => '/files/etc/puppetlabs/puppet/puppet.conf/master',
      changes => [
        'set storeconfigs true',
        'set storeconfigs_backend puppetdb',
      ],
      notify  => Service['puppetserver']
    }
    file { '/etc/puppetlabs/puppet/routes.yaml':
      content => epp('puppetserver/routes.yaml.epp'),
      notify  => Service['puppetserver']
    }
    file { '/etc/puppetlabs/puppet/puppetdb.conf':
      content => epp('puppetserver/puppetdb.conf.epp',
        {
        puppetdb_server => $puppetserver::puppetdb_server,
        puppetdb_port   => $puppetserver::puppetdb_port,
        }),
      notify  => Service['puppetserver']
    }
  }
}
