# docs
class puppetserver::install {

  package { 'puppet-agent':
    ensure => $puppetserver::agent_version,
  }

  package { 'puppetserver':
    ensure => $puppetserver::version,
  }

  if $puppetserver::puppetdb {
    package { 'puppetdb-termini':
      ensure => $puppetserver::puppetdb_version,
    }
  }

}
