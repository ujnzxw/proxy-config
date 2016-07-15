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


#------------Functions------------------------------------

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
#-----------------Main------------------------------------

case "$1" in
	manual )
		set_proxy_manual
	;;

	none )
		set_proxy_none
	;;

	* )
		# Using pc in home
		if [ $(ip a | grep 192.168) ]; then
			uset_proxy_none
		# Using pc in office
		else
			set_proxy_manual

		fi
	;;

esac
