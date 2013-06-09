define sabnzbdplus::server (
  $template = 'sabnzbdplus/server.erb',

  $connections = 4,
  $enable = 1,
  $fillserver = 0,
  $host = undef,
  $optional = 0,
  $password = undef,
  $port = str2bool($ssl) ? { 1 => 563, default => 119 },
  $retention = 0,
  $ssl = 1,
  $timeout = 120,
  $username = undef,
) {

  concat::fragment{ "sabnzbdplus_server_${$name}":
    target  => '/etc/sabnzbdplus/sabnzbd.ini',
    content => [template($template)],
    order   => 02,
  }
}
