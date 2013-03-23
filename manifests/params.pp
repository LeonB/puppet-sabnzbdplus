# Class: sabnzbdplus::params
#
# This class defines default parameters used by the main module class sabnzbdplus
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to sabnzbdplus class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class sabnzbdplus::params {

	### Application related parameters

	$package_name = $::operatingsystem ? {
		default => 'sabnzbdplus'
	}

	$enabled = true

	$api_key = '""' # sabnzbdplus default
	$complete_dir = '/var/sabnzbdplus'
	$download_dir = '/var/sabnzbdplus/incomplete'
	$email_from = "sabnzbdplus@${fqdn}"
	$email_server = 'localhost'
	$email_to = "root@${fqdn}"
	$host = '127.0.0.1'
	$nzb_key = '""'
	$port = '9090'
	$user = 'sabnzbdplus'

	$nzbmatrix_apikey = '""'
	$nzbmatrix_username = '""'

	$newzbin_username = '""'
	$newzbin_password = '""'
	$newzbin_url = 'www.newzbin2.es'

}
