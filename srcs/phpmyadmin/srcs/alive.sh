#!/bin/bash
sleep 15
while [ $(ps aux | grep php-fpm | wc -l) -gt 1 ]; do
	sleep 5
done
pkill nginx