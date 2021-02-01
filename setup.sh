#!/bin/bash

function build_spec() 
{
	printf "\e[39mSTART BUILDING \e[5;92m${1}\e[0m\r"
	start=`date +%s`
	docker build srcs/$1/. -t $1-image >> last.log
	kubectl apply -f srcs/$1/yaml/. >> last.log
	end=`date +%s`
	runtime=$((end-start))
	printf "\e[K\e[92m ${1} DONE (in ${runtime}s)!\e[0m\n"
}

function build_services()
{
	build_spec influxdb
	build_spec mysql
	build_spec nginx
	build_spec phpmyadmin
	printf "\e[36mPlease wait 10 sec...\n"
	sleep 10
	build_spec wordpress
	build_spec ftps
	build_spec grafana
}

function metallinstall()
{
	printf "\e[39m START BUILDING \e[5;92mmetallb\e[0m\r"
	start=`date +%s`
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml >> last.log
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml >> last.log
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> last.log
	kubectl apply -f srcs/metallb/. >> last.log
	end=`date +%s`
	runtime=$((end-start))
	printf "\e[K\e[92m metallb DONE (in ${runtime}s)!\e[0m\n"
}

function sedding()
{
	sed -e "s/GLOB_IP/$GLOBIP/g" srcs/templates/wp.sh >> srcs/wordpress/srcs/wp.sh
	sed -e "s/IP_S/$GLOBIP/g;s/IP_E/$GLOBIP/g" srcs/templates/metallb.yaml >> srcs/metallb/metallb.yaml
	sed -e "s/GLOB_IP/$GLOBIP/g" srcs/templates/Dockerfile_ftps >> srcs/ftps/Dockerfile
}

function check_brew()
{
	BREW_INSTALLED=$(brew -v | grep "Homebrew" | wc -l | sed s/" "//g)
	if [ "$BREW_INSTALLED" != "3" ]; then
		mkdir $HOME/.brew && curl -fsSL https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $HOME/.brew
		mkdir -p /tmp/.$(whoami)-brew-locks
		mkdir -p $HOME/.brew/var/homebrew
		ln -s /tmp/.$(whoami)-brew-locks $HOME/.brew/var/homebrew/locks
		export PATH="$HOME/.brew/bin:$PATH"
		brew update && brew upgrade
	else
		printf "\e[92m Brew already installed !\n"
	fi
	MININSTALLED=$(minikube version | grep "commit:" | wc -l | sed s/" "//g)
	if [ "$MININSTALLED" != "1" ]; then
		brew install minikube
	else
		printf "\e[92m Minikube already installed !\n"
	fi
}

function start()
{
	check_brew
	rm -f last.log
	printf "\e[91m DELETING minikube\r"
	minikube delete > last.log
	printf "\e[K\e[91m minikube deleted !\n"
	printf "\e[39m STARTING \e[92mminikube\r"
	minikube start --driver=virtualbox >> last.log
	printf "\e[K\e[92m minikube started !\n"
	export GLOBIP=$(minikube ip)
	eval $(minikube docker-env)
	sedding
	metallinstall
	build_services
	tput cnorm
	minikube dashboard

}

function clear()
{
	check_brew
	printf "\e[91m"
	kubectl delete service --all
	kubectl delete pods --all
	kubectl delete deployment --all
	rm -f last.log
	printf "logs \"last.log\" deleted\n"
	printf "\e[0m"
	minikube delete
}

if [ $# -eq 0 ]; then
	start
elif [ $# -eq 1 ]; then
	if [ "$1" == "start" ]; then
		start
	elif [ "$1" == "clear" ]; then
		clear
	elif [ "$1" == "dep" ]; then
		check_brew
	else
		echo "Wrong arg"
	fi
else
	echo "Too much args"
fi