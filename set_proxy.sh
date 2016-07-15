#!/bin/bash
#
#-----------------------------------------------------------
# Author       : ujnzxw
# Description  : Set GNOME proxy
# Date         : 2016-07-15
# Note         : Please set the proxy manually first.
#			   : If you want to change proxy by script, please
#              : set the proxy setting files:
#				 /etc/environment  - reload file when reboot
#				 /etc/apt/apt.conf - apt used               #-----------------------------------------------------------


#--------------Functions------------------------------------

# help function
function echo_help()
{
	echo "Usage: $0 none|manual|auto"
}
# change proxy to none mode
function set_proxy_none()
{
	echo " Set proxy mode - none"
	gsettings set org.gnome.system.proxy mode none
}

# change proxy to manual mode
function set_proxy_manual()
{
	echo " Set proxy mode - manual"
	gsettings set org.gnome.system.proxy mode manual
}
# change proxy to automatic
function set_proxy_auto()
{
	echo " Set proxy mode - automatic"
	gsettings set org.gnome.system.proxy mode auto
}
#-------------------Main------------------------------------

case "$1" in
	"-h"|"--help" )
		echo_help
	;;

	manual )
		set_proxy_manual
	;;

	none )
		set_proxy_none
	;;

	automatic|auto )
		set_proxy_auto
	;;

	* )
		# success - $?=0; fail - $?=1
		ip a | grep 192.168 > /dev/null
		# check if grep is successful
		if [ $? -eq 0 ]; then
			# Using pc in home
			set_proxy_none
		else
			# Using pc in office
			set_proxy_manual

		fi
	;;

esac
