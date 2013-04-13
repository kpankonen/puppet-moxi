puppet-moxi
====

Overview
--------

The moxi module installs and configures the Couchbase Moxi Server

* http://www.couchbase.com/docs/moxi-manual-1.8/index.html


Usage
------

The `moxi::install` class installs the moxi server

The `moxi::config` class has several parameters used to configure the moxi server

    class { 'moxi::config':
      servers     => [ 'couch01',
                       'couch02',
                       '192.168.1.100',
                       '192.168.1.101', ]
      bucket      => 'default',
      listen_port => 11211,
    }

Required Parameters
------

####`servers`

This is an array of Couchbase servers (hostname or IP only) that the moxi server will connect to

####`bucket`

This parameter specifies which Couchbase bucket to use

Optional Parameters
------

####`port`

This parameter specifies which port the Couchbase servers are on, defaults to 8091

####`usr`

This paramater specifies the username of the bucket, defaults to unset

####`pwd`

This parameter specifies the password of the bucket, defaults to unset

####`port_listen`

This parameter specifies what port the moxi server will listen on, defaults to 11211

####`config_dir`
This parameter specifies the config directory, defaults to /opt/moxi/etc

####`downstream_max`
defaults to 1024

####`downstream_conn_max`
defaults to 4

####`downstream_conn_queue_timeout`
defaults to 200

####`downstream_timeout`
defaults to 5000

####`wait_queue_timeout`
defaults to 200

####`connect_max_errors`
defaults to 5

####`connect_retry_interval`
defaults to 30000

####`connect_timeout`
defaults to 400

####`auth_timeout`
defaults to 100

####`cycle`
defaults to 200

####`moxi_user`
defaults to moxi

####`moxi_group`
defaults to moxi
