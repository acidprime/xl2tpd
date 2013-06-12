# == Class: xl2tpd
#
# Full description of class xl2tpd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { xl2tpd:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class xl2tpd(
  $wan_ip,
  $ppp_device_ip,
  $ip_range_start,
  $ip_range_end,
){
  require xl2tpd::firewall

  package {'xl2tpd':
    ensure => present,
  }

  file {'/etc/xl2tpd/xl2tpd.conf':
    ensure  => file,
    content => template("${module_name}/xl2tpd.conf.erb"),
    require => Package['xl2tpd'],
  }

  service {'xl2tpd':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/xl2tpd/xl2tpd.conf'],
  }
}
