class sabnzbdplus(
	$package_name  = params_lookup( 'package_name' ),
	$enabled       = params_lookup( 'enabled' ),

	$api_key            = params_lookup( 'api_key' ),
	$complete_dir       = params_lookup( 'complete_dir' ),
	$download_dir       = params_lookup( 'download_dir' ),
	$email_from         = params_lookup( 'email_from' ),
	$email_server       = params_lookup( 'email_server' ),
	$email_to           = params_lookup( 'email_to' ),
	$host               = params_lookup( 'host' ),
	$nzb_key            = params_lookup( 'nzb_key' ),
	$port               = params_lookup( 'port' ),
	$user               = params_lookup( 'user' ),

	$nzbmatrix_apikey   = params_lookup( 'nzbmatrix_apikey' ),
	$nzbmatrix_username = params_lookup( 'nzbmatrix_username' ),

	$newzbin_username   = params_lookup( 'newzbin_username' ),
	$newzbin_password   = params_lookup( 'newzbin_password' ),
	$newzbin_url        = params_lookup( 'newzbin_url' ),
  ) inherits sabnzbdplus::params {

  	$ensure = $enabled ? {
  		true => present,
  		false => absent
  	}

	include sabnzbdplus::package, sabnzbdplus::config, sabnzbdplus::service
}
