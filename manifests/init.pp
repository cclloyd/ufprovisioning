class ufprovisioning {
	

	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	
}

class ufprovisioning::ufprovisioning {
	
	
	include ufprovisioning::params
	
	include ufprovisioning::install
	include ufprovisioning::config
	include ufprovisioning::service
	
}
