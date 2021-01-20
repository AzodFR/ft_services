#!/bin/bash

function build_spec()
{
	docker build srcs/$1/. -t $1-image
	kubectl apply -f srcs/$1/yaml/.
}

function metallb_install()
{
  sed -e "s/IP_S/$GLOBAL_IP/g;s/IP_E/$GLOBAL_IP/g" srcs/metallb/example_config.yaml > srcs/metallb/metallb.yaml
  kubectl apply -f srcs/metallb/namespace.yaml
  kubectl apply -f srcs/metallb/manifest.yaml
  kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
  kubectl apply -f srcs/metallb/metallb.yaml
}

function ftps_ip
{
	sed -e "s/FTPS_IP/$GLOBAL_IP/g" srcs/vsftpd/srcs/template.conf > srcs/vsftpd/srcs/vsftpd.conf
}

function start()
{
	kubectl apply -f srcs/volume.yaml
	metallb_install
	ftps_ip
	build_spec influxdb
	build_spec grafana
	build_spec vsftpd
	build_spec nginx
	build_spec vsftpd
	echo "Available at $GLOBAL_IP"
	minikube dashboard
}


minikube delete
MK_OFF=$(minikube ip | grep "start" | wc -l | cut -c8-)

if [[ "$MK_OFF" == 1 ]]; then
	minikube start
fi

eval "$(minikube docker-env)"
GLOBAL_IP=$(minikube ip)
start
