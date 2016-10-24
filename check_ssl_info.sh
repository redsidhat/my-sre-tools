#!/bin/bash
if [ -z $1 ]; then
    echo "Pass filename which contains the list of domain names"
    sleep 2
    exit 2
fi
filename= $1
if [ -z $2 ]; then
    echo "No certificate name is passed ignoring name check is performed."
 	while read line; do
     	echo $line
     	echo " "
     	echo | openssl s_client -connect $line:443 2>/dev/null | openssl x509 -noout -dates
     	echo "----------------------"
 	done <$filename
else
	cert_name= $2
	while read line; do
  	if [ "$(echo | openssl s_client -connect $line:443 2>/dev/null | openssl x509 -noout -subject 2>/dev/null|awk -F '=' '{print $11}')" == "*.new.livestream.com" ]; then
  		echo $line
    	echo " "
    	echo | openssl s_client -connect $line:443 2>/dev/null | openssl x509 -noout -dates
    	echo "----------------------"

	fi
	done <$filename
fi
