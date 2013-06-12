class xl2tpd::ppp(
  $primary_dns,
  $second_dns,
){
  require xl2tpd
  file {'/etc/ppp/options.xl2tpd':
   ensure  => file,
   content => template("${module_name}/options.xl2tpd.erb"),
  }
  file {'/etc/ppp/chap-secrets':
    ensure  => file,
    mode    => '600',
    content => template("${module_name}/chap-secrets.erb"),
  }
}
