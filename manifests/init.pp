# docs
class puppetserver(
  String $certname,
  String $version,
  Boolean $autosign,
  String $agent_version,
  String $java_args,
  String $system_config_path,
  Boolean $puppetdb,
  String $puppetdb_version,
  String $puppetdb_server,
  String $puppetdb_port,
  ) {

  include puppetserver::install
  include puppetserver::config
  include puppetserver::service

  Class['puppetserver::install'] ->
  Class['puppetserver::config'] ->
  Class['puppetserver::service']

}
