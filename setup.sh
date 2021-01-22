#!/bin/bash

function build_spec()
{
	docker build srcs/$1/. -t $1-image
	kubectl apply -f srcs/$1/yaml/.
}

function metallb_install()
{
  sed -e "s/IP_S/$MINIKUBE_START/g;s/IP_E/$MINIKUBE_END/g" srcs/metallb/example_config.yaml > srcs/metallb/metallb.yaml
  kubectl apply -f srcs/metallb/namespace.yaml
  kubectl apply -f srcs/metallb/manifest.yaml
  kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
  kubectl apply -f srcs/metallb/metallb.yaml
}

function start()
{
	kubectl apply -f srcs/volume.yaml
	metallb_install
	build_spec vsftpd
	build_spec phpmyadmin
	build_spec influxdb
	build_spec grafana
	build_spec nginx
	echo "Available at $GLOBAL_IP"
	minikube dashboard
}


minikube delete
MK_OFF=$(minikube ip | grep "start" | wc -l | cut -c8-)

if [[ "$MK_OFF" == 1 ]]; then
	minikube start --driver=docker
fi

eval "$(minikube docker-env)"
GLOBAL_IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
IP_1_3=$(echo "$GLOBAL_IP" | cut -d '.' -f 1,2,3)
START=$(echo "$GLOBAL_IP" | cut -d '.' -f 4)
MINIKUBE_START="$IP_1_3".$((START + 1))
MINIKUBE_END="$IP_1_3".254
sed -i -e "s/pasv_address=.*/pasv_address=$MINIKUBE_START/g" ./srcs/vsftpd/srcs/vsftpd.conf
start
