class sabnzbdplus::package {

	package  { $sabnzbdplus::package_name:
		ensure => $sabnzbdplus::ensure,
		require => Apt::Source['sabnzbdplus'],
	}

	# The SABnzbd+ ppa
	# apt::ppa { "ppa:jcfp/ppa": }

	apt::source { 'sabnzbdplus':
		ensure      => $sabnzbdplus::ensure,
		location    => 'http://ppa.launchpad.net/jcfp/ppa/ubuntu',
		# key         => '977C43A8BA684223',
		include_src => false,
	}
}
