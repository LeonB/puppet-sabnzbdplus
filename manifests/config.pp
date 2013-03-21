class sabnzbdplus::config {

	nginx::vhost::snippet { 'sabnzbdplus':
		vhost   => 'default',
		content => template('sabnzbdplus/nginx_vhost.erb'),
		ensure  => $sabnzbdplus::ensure
	 }

}
