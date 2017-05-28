# Main class
## Parameters
### certname: Certificate name for the server and agent
### version: package version for puppetserver
### autosign: Set the parameter autosign inside puppet.config
### agent_version: package version for puppet agent
### java_args: Set the JAVA_ARGS for puppetserver JVM
### system_config_path: The path to be used for the system config
### puppetdb: Configure puppetdb integration
### puppetdb_version: package version for puppetdb
### puppetdb_server: host or ip for puppetdb integration
### puppetdb_port: port of puppetdb service

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

  Class['puppetserver::install']
  -> Class['puppetserver::config']
    -> Class['puppetserver::service']

}
