#!/bin/bash

function get_ip()
{
	GLOBAL_IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p | cut -d '.' -f 1,2,3)
	START_IP=$GLOBAL_IP'.1'
	END_IP=$GLOBAL_IP'.254'
}

function build_spec()
{
	docker build srcs/$1/. -t $1-image
	kubectl apply -f srcs/$1/yaml/.
}

function metallb_install()
{
  sed -e "s/IP_S/$START_IP/g;s/IP_E/$END_IP/g" srcs/metallb/example_config.yaml > srcs/metallb/metallb.yaml
  kubectl apply -f srcs/metallb/namespace.yaml
  kubectl apply -f srcs/metallb/manifest.yaml
  kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
  kubectl apply -f srcs/metallb/metallb.yaml
}


function start()
{
	get_ip
	metallb_install
	build_spec vsftpd
	minikube dashboard
}

MK_OFF=$(minikube ip | grep "start" | wc -l | cut -c8-)

if [[ "$MK_OFF" == 1 ]]; then
	minikube start
fi

eval "$(minikube docker-env)"
start
