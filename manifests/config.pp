class sabnzbdplus::config {

	nginx::vhost::snippet { 'sabnzbdplus':
		vhost   => 'default',
		content => template('sabnzbdplus/nginx_vhost.erb'),
		ensure  => $sabnzbdplus::ensure
	 }

	augeas { "/etc/default/puppet":
		context => '/files/etc/default/sabnzbdplus',
		changes => [
			"set USER ${sabnzbdplus::user}",
			"set CONFIG /etc/sabnzbdplus/",
		],
		notify  => Class['sabnzbdplus::service'],
	}

	users::account { $sabnzbdplus::user:
	    ensure     => $sabnzbdplus::ensure,
	    uid        => 501,
	    shell      => '/bin/false',
	    comment    => 'sabnzbdplus daemon'
	}

	file { '/etc/sabnzbdplus':
		ensure  => $sabnzbdplus::ensure ? { present => directory, default => $sabnzbdplus::ensure },
		force   => $true,
		owner   => $sabnzbdplus::user,
		group   => $sabnzbdplus::user,
		mode    => 0640; # rwx,rx
	}

	file {
		[
			'/etc/sabnzbdplus/admin',
			'/etc/sabnzbdplus/logs',
			'/etc/sabnzbdplus/scripts',
			$sabnzbdplus::complete_dir,
			$sabnzbdplus::download_dir,
		]:
			ensure  => $sabnzbdplus::ensure ? { present => directory, default => $sabnzbdplus::ensure },
			force   => $true,
			owner   => $sabnzbdplus::user,
			group   => $sabnzbdplus::user,
			mode    => 0640; # rwx,rx
	}

	file { '/etc/sabnzbdplus/scripts/sabToSickBeard.py':
		ensure  => $sabnzbdplus::ensure,
		owner   => $sabnzbdplus::user,
		group   => $sabnzbdplus::user,
		mode    => 0550, # rwx,rx
		source => 'puppet:///modules/sabnzbdplus/sabToSickBeard.py',
	}

	concat{ '/etc/sabnzbdplus/sabnzbd.ini':
		owner   => $sabnzbdplus::user,
		group   => $sabnzbdplus::user,
		mode    => 0640, # rwx,rx
		require => Class['sabnzbdplus::package'],
		notify  => Class['sabnzbdplus::service'],
	}

	concat::fragment{ 'sabnzbdplus_main':
		target => '/etc/sabnzbdplus/sabnzbd.ini',
		content => template("sabnzbdplus/sabnzbd.ini.erb"),
		order   => 01,
	}
}
