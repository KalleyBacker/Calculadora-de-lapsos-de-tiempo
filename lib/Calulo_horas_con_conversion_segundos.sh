#!/bin/env bash 

#<<EOF 
#Author: 
#	
#	[ Juan Carlos Morla Reyes ]
#
#Linkedin 
#	
#	[ https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/ ]
#
#VERSION 
#		1.3.52 
#
#
#NAME 
#       Calulo_horas_con_conversion_segundos.sh - resta la diferencia de horas
#
#SYNOPSIS
#		Cargar las functiones a su entorno		
#		1) source $(pwd)/lib/Calulo_horas_con_conversion_segundos.sh
#		
#   	2) FORMATO DE ENTRADA PARA PARAMETRO_$1_$2  ==== 'YYYY/MM/DD HH:MM:SS'
#		 
#		Parametros que acepta la function 
#		3) Start_time-End_time ['PARAMETRO_$1'] ['PARAMETRO_$2'] [PARAMETRO_$3]
#		
#		Para mostrar timetamps
#		4) Start_time-End_time '2022/12-/02 00:05:44' '2022/12/02 00:10:57' timetamps 
#					
#
#DESCRIPTION
#        Calulo_horas_con_conversion_segundos script que incorpora funciones destinadas adherirse a 
#		 programas externos para agregarle la funcionalidad de restar tiempos de forma precisa.
#
#		Tiempo Unix (timetamps)
#		El tiempo Unix (también conocido como tiempo POSIX o tiempo Epoch) es un sistema 
#		para describir instantes en el tiempo, definido como el número de segundos que 
#		han transcurrido desde las 00:00:00 hora universal coordinada (UTC) 3 el jueves 
#		1 de enero de 1970, no contando los segundos bisiestos. Se usa ampliamente en 
#		sistemas operativos y formatos de archivo similares a Unix y muchos otros.Debido 
#		a que no maneja segundos bisiestos, no es una representación lineal del tiempo ni 
#		una representación real de UTC.
#EOF

#set -x
function  Start_time-End_time {
	
	#funcion principal encargada de tomar los datos y procesarlos
	#parametros hora inicio $1 hora final $1   opcional timepams $3
	
	local Start_time=$1
	local End_time=$2
	local timetamps=$3
	###################################
	local COLOR_GREEN=$(tput setaf 2)
	local COLOR_RED=$(tput setaf 1)
	local NULL_COLOR=$(tput sgr0)



	function verifica_contenido_vars_START_END {
	
		#Verifica que las variables Start_time y End_time tengan un valor almacenado 		
		if [[ -z ${Start_time} ]];then
		
			echo -n "Error, valor no identiciado en Start_time=${Start_time}? " 1>&2 && End_time=0 && STATUS=1 
		
		fi 	

		if [[ -z ${End_time} ]];then
		
			echo -n "Error, valor no identiciado en End_Time=${End_time}? " 1>&2 && Start_time=0 && STATUS=1
		
		fi 	
	}

	function convertidor_yyyy_mm_dd_HH_MM_SS_timestamps {
		
		#convierte el contenido de las variables start y end en segundos
		verifica_contenido_vars_START_END
		 
		 timestamps_Start_time=$(date  -u --date "${Start_time}" +%s)
		 timestamps_End_time=$(date -u --date "${End_time}" +%s)
		 
	}

	function verifica_timestamps_esten_correctos {
		
		#verifica que la variable timestamps_End_time sea mayor a timestamps_Start_time  
		convertidor_yyyy_mm_dd_HH_MM_SS_timestamps
		
		if [[ ${timestamps_End_time} -lt ${timestamps_Start_time} ]];then
			STATUS=1
		fi 	
	}

	function resta_timestamps {
		
		#resta los segundos
		verifica_timestamps_esten_correctos
		 Segundos_timestamps_star_end="$(( ${timestamps_End_time}-${timestamps_Start_time} ))"
		
	}

	function print_formato_yyyy_dd_hh_mm_ss_timestamps {
		
		if [[ ${timetamps} = timetamps ]];then
			echo ${Segundos_timestamps_star_end} 	
		
		else 	
			printf '[%dy/%dd/ %dh:%dm:%ds]\n' $((${Segundos_timestamps_star_end}/60/60/24/365))\
				$((${Segundos_timestamps_star_end}/60/60/24%365))\
					$((${Segundos_timestamps_star_end}/3600%24))\
						$((${Segundos_timestamps_star_end}%3600/60))\
							$((${Segundos_timestamps_star_end}%60))
		
		fi 
	}

	function colors_print {
		
		resta_timestamps

		if [[ ${STATUS} -eq 0 ]];then
			echo -n ${COLOR_GREEN}
			print_formato_yyyy_dd_hh_mm_ss_timestamps
			echo -n ${NULL_COLOR}
		else 			
			echo -n ${COLOR_RED}
			print_formato_yyyy_dd_hh_mm_ss_timestamps
			echo  -n ${NULL_COLOR}
			STATUS=0
		fi	
	
	} 

	colors_print
}	
return 0