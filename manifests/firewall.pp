class xl2tpd::firewall {
  firewall { '1000 L2TP IKE':
    ensure  => 'present',
    action => 'accept',
    chain   => 'INPUT',
    dport   => ['500'],
    proto   => 'udp',
  }
  firewall { '1001 L2TP NAT-T':
    ensure => 'present',
    action => 'accept',
    chain  => 'INPUT',
    dport  => ['4500'],
    proto  => 'udp',
  }
  firewall { '1002 L2TP Traffic':
    ensure => 'present',
    action => 'accept',
    chain  => 'INPUT',
    proto  => 'udp',
    dport  => ['1701'],
    table    => 'filter',

  }
  firewall { '1003 L2TP Traffic':
    ensure => 'present',
    action => 'accept',
    chain  => 'INPUT',
    proto  => 'tcp',
    dport  => ['1701'],

  }
  firewall { '1004 Do not NAT VPN traffic':
    ensure   => 'present',
    outiface => 'eth0',
    chain    => 'POSTROUTING',
    source   => "${::network_eth0}/24",
    table    => 'nat',
    jump     => 'MASQUERADE',
  }
  firewall { '1005 IP':
    ensure => 'present',
    action => 'accept',
    chain  => 'FORWARD',
    source => "${::network_eth0}/24",
  }
}
