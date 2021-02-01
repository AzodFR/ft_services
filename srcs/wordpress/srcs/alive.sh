#!/bin/bash
sleep 30
while [ $(ps aux | grep php-fpm | wc -l) -gt 1 ]; do
	sleep 5
done
sleep 5
while [ $(ps aux | grep php-fpm | wc -l) -gt 1 ]; do
	sleep 5
done
pkill nginx