class sabnzbdplus::package {

    package  { $sabnzbdplus::packages:
        ensure  => $sabnzbdplus::ensure,
        require => Apt::Source['sabnzbdplus'],
    }

    # The SABnzbd+ ppa
    # apt::ppa { "ppa:jcfp/ppa": }

    apt::source { 'sabnzbdplus':
        ensure      => $sabnzbdplus::ensure,
        location    => 'http://ppa.launchpad.net/jcfp/ppa/ubuntu',
        key         => 'F13930B14BB9F05F',
        include_src => false,
    }
}
