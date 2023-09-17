#!/bin/sh

bits="$(getconf LONG_BIT)"

if [ $bits == "64" ]
	 then
			 echo "󰻠"
			 else
					 echo "󰻟"
					 fi
