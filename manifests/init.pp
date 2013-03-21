class sabnzbdplus(
	$package_name = params_lookup( 'package_name' ),
	$enabled       = params_lookup( 'enabled' )
  ) inherits sabnzbdplus::params {

  	$ensure = $enabled ? {
  		true => present,
  		false => absent
  	}

	include sabnzbdplus::package, sabnzbdplus::config
}
