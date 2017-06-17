# Puppetserver class.
#
# This is a class to install and manage Puppetserver:
#
# @example Declaring the class
#   include puppetserver
#
# @param [String] certname Certificate name for the server and agent
# @param [String] version Package version for puppetserver
# @param [Boolean] autosign Set the parameter autosign inside puppet.conf
# @param [String] agent_version Package version for puppet agent
# @param [String] java_args Set the JAVA_ARGS for puppetserver JVM
# @param [String] system_config_path The path to be used for the system config
# @param [Boolean] puppetdb Define if puppetdb integration is enabled
# @param [String] puppetdb_version Package version for puppetdb
# @param [String] puppetdb_server Host or ip for puppetdv service
# @param [Integer] puppetdb_port Port to connect for puppetdb service

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
  Integer[1024,65535] $puppetdb_port,
  ) {

  include puppetserver::install
  include puppetserver::config
  include puppetserver::service

  Class['puppetserver::install']
  -> Class['puppetserver::config']
    -> Class['puppetserver::service']

}
