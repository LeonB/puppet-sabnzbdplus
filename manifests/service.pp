class sabnzbdplus::service {

    service { 'sabnzbdplus':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
        require    => Class['sabnzbdplus::package'],
    }
}
