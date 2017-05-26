# docs
class puppetserver::service {

  service { 'puppetserver':
    ensure => 'running',
    enable => true,
  }

  service { 'puppet':
    ensure => 'running',
    enable => true,
  }

}
