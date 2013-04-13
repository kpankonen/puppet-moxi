# Configures the moxi proxy
#
# Requires stdlib
#
# Parameters:
#   $servers                       - required - array of Couchbase hosts
#   $bucket                        - required
#   $port                          - optional - defaults to 8091
#                                             - port that Couchbase is on
#   $usr                           - optional - bucket username
#   $pwd                           - optional - bucket password
#   $port_listen                   - optional - defaults to '11211'
#   $downstream_max                - optional - defaults to '1024'
#   $downstream_conn_max           - optional - defaults to '4'
#   $downstream_conn_queue_timeout - optional - defaults to '200'
#   $downstream_timeout            - optional - defaults to '5000'
#   $wait_queue_timeout            - optional - defaults to '200'
#   $connect_max_errors            - optional - defaults to '5'
#   $connect_retry_interval        - optional - defaults to '30000'
#   $connect_timeout               - optional - defaults to '400'
#   $auth_timeout                  - optional - defaults to '100'
#   $cycle                         - optional - defaults to '200'
#   $moxi_user                     - optional - defaults to 'moxi'
#   $moxi_group                    - optional - defaults to 'moxi'
#   $config_dir                    - optional - defaults to '/opt/moxi/etc'

class moxi::config (
  $servers                       = undef,
  $bucket                        = undef,
  $port                          = 8091,
  $usr                           = "NOTSET",
  $pwd                           = "NOTSET",
  $port_listen                   = 11211,
  $downstream_max                = 1024,
  $downstream_conn_max           = 4,
  $downstream_conn_queue_timeout = 200,
  $downstream_timeout            = 5000,
  $wait_queue_timeout            = 200,
  $connect_max_errors            = 5,
  $connect_retry_interval        = 30000,
  $connect_timeout               = 400,
  $auth_timeout                  = 100,
  $cycle                         = 200,
  $moxi_user                     = 'moxi',
  $moxi_group                    = 'moxi',
  $config_dir                    = '/opt/moxi/etc',
) {

  # Validate config values
  if $bucket == undef {
    fail('Moxi::config: bucket must be defined')
  }
  if $servers == undef {
    fail('Moxi::config: servers is a required parameter')
  }
  if !is_array($servers) {
    fail('Moxi::config: servers must be an array')
  }
  if $port_listen !~ /^\d+$/ {
    fail('Moxi::config: port_listen must be an integer')
  }
  if $port_listen >= 65535 {
    fail('Moxi::config: valid port range is 1-65535')
  }
  if $downstream_max !~ /^\d+$/ {
    fail('Moxi::config: downstream_max must be an integer')
  }
  if $downstream_conn_max !~ /^\d+$/ {
    fail('Moxi::config: downstream_conn_max must be an integer')
  }
  if $downstream_conn_queue_timeout !~ /^\d+$/ {
    fail('Moxi::config: downstream_conn_queue_timeout must be be an integer')
  }
  if $downstream_timeout !~ /^\d+$/ {
    fail('Moxi::config: downstream_timeout must be an integer')
  }
  if $wait_queue_timeout !~ /^\d+$/ {
    fail('Moxi::config: wait_queue_timeout must be an integer')
  }
  if $connect_max_errors !~ /^\d+$/ {
    fail('Moxi::config: connect_max_errors must be an integer')
  }
  if $auth_timeout !~ /^\d+$/ {
    fail('Moxi::config: auth_timeout must be an integer')
  }
  if $cycle !~ /^\d+$/ {
    fail('Moxi::config: cycle must be an integer')
  }

  file { "${config_dir}/moxi.cfg":
    ensure  => 'file',
    content => template('moxi/moxi.erb'),
    owner   => $moxi_user,
    group   => $moxi_group,
    mode    => '0600',
    require => Package['moxi-server'],
  }

  file { "${config_dir}/moxi-cluster.cfg":
    ensure  => 'file',
    content => template('moxi/moxi-cluster.erb'),
    owner   => $moxi_user,
    group   => $moxi_group,
    mode    => '0600',
    require => Package['moxi-server'],
  }
}
