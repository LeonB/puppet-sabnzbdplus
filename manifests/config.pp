class sabnzbdplus::config {

    $directory_ensure = $sabnzbdplus::ensure ? {
        present => directory,
        default => $sabnzbdplus::ensure
    }

    nginx::vhost::snippet { 'sabnzbdplus':
        ensure  => $sabnzbdplus::ensure
        vhost   => 'default',
        content => template('sabnzbdplus/nginx_vhost.erb'),
    }

    augeas { '/etc/default/sabnzbdplus':
        context => '/files/etc/default/sabnzbdplus',
        changes => [
            "set USER ${sabnzbdplus::user}",
            'set CONFIG /etc/sabnzbdplus/',
        ],
        notify  => Class['sabnzbdplus::service'],
    }

    users::account { $sabnzbdplus::user:
        ensure     => $sabnzbdplus::ensure,
        home       => '/var/sabnzbdplus',
        uid        => 501,
        shell      => '/bin/false',
        comment    => 'sabnzbdplus daemon'
    }

    file {
        [
            '/etc/sabnzbdplus',
            '/etc/sabnzbdplus/admin',
            '/etc/sabnzbdplus/logs',
        ]:
        ensure  => $directory_ensure,
        force   => true,
        owner   => $sabnzbdplus::user,
        group   => $sabnzbdplus::user,
        mode    => '0640'; # rwx,rx
    }

    # file {
    #     [
    #         $sabnzbdplus::complete_dir,
    #         $sabnzbdplus::download_dir,
    #     ]:
    #         ensure  => $directory_ensure,
    #         force   => true,
    #         owner   => $sabnzbdplus::user,
    #         group   => $sabnzbdplus::user,
    #         mode    => 0644; # rw,r,r
    # }

    file { '/etc/sabnzbdplus/scripts/':
        ensure  => $directory_ensure,
        force   => true,
        recurse => true,
        owner   => $sabnzbdplus::user,
        group   => $sabnzbdplus::user,
        mode    => '0640', # rw,r
        source  => 'puppet:///modules/sabnzbdplus/scripts/',
    }

    concat { '/etc/sabnzbdplus/sabnzbd.ini':
        owner   => $sabnzbdplus::user,
        group   => $sabnzbdplus::user,
        mode    => 0640, # rw,r
        require => Class['sabnzbdplus::package'],
        notify  => Class['sabnzbdplus::service'],
    }

    concat::fragment { 'sabnzbdplus_main':
        target  => '/etc/sabnzbdplus/sabnzbd.ini',
        content => template('sabnzbdplus/sabnzbd.ini.erb'),
        order   => 01,
    }
}
