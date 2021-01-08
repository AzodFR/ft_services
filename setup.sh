#!/bin/bash

function get_ip()
{
	GLOBAL_IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p | cut -d '.' -f 1,2,3)
	START_IP = GLOBAL_IP'.1'
	END_IP = GLOBAL_IP'.254'
}

function build_spec()
{
	docker build srcs/$1/. -t $1-image
	kubectl apply -f srcs/$1/yaml/.
}

function start()
{
build_spec "nginx"
minikube dashboard
}

MK_OFF=$(minikube ip | grep "start" | wc -l | cut -c8-)

if [[ "$MK_OFF" == 1 ]]; then
	minikube start
fi

eval "$(minikube docker-env)"
start
