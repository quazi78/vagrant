  file{'/tmp/hello':
    ensure => file,
    content => 'Cake',
    mode => '0644'
  }
