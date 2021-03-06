


notice("Configuring user 'michael'")

user { 'michael':
	ensure           => 'present',
	name			 => 'michael',	
	home             => '/home/michael',
	password         => 'slipspacetransmission',
	password_max_age => '99999',
	password_min_age => '0',
	shell            => '/bin/bash',
	#group			 => 'michael'
	managehome		 => true,
}

exec { "Add michael to sudo":
	command => '/usr/sbin/usermod -aG sudo michael',
	user 	=> 'root',
	path	=> '/home/michael'
}

file { "/home/michael/.bashrc":
	ensure => "present",
	source  => "puppet:///modules/ufprovisioning/templates/bashrc",
	owner   => 'michael',
	group   => 'michael',
	mode    => '0755'
}

notice("Configuring Webserver")

package { 'tree':
	ensure => installed,
}	
package { 'nginx':
	ensure => installed,
}
package { 'python-pip':
	ensure => installed,
}
package { 'composer':
	ensure => installed,
}
package { 'git':
	ensure => installed,
}
package { 'tmux':
	ensure => installed,
}

file { "/etc/nginx/sites-available/cclloyd.com.conf":
	ensure => "present",
	source  => "puppet:///modules/ufprovisioning/conf/cclloyd.com.conf",
	owner   => 'root',
	group   => 'root',
	mode    => '0755',
	require => Package['nginx']
}




file { '/etc/nginx/sites-enabled/cclloyd.com.conf':
	ensure => 'link',
	target => '/etc/nginx/sites-available/cclloyd.com.conf',
}
service { 'nginx':
	ensure     => running,
	enable     => true,
	hasstatus  => true,
	hasrestart => true,
	require => Package['nginx'],
}

