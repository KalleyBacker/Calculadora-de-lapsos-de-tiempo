#!/bin/env bash 

#Author https://www.linkedin.com/in/juan-carlos-morla-reyes-6410a91b3/
#version 1.0.000 
#bug al suminitrar fechas con dias diferentes explota.
#
#
#NAME 
#       Calulo_horas_con_conversion_segundos.sh - resta la diferencia de horas
#
#SYNOPSIS
#		source $(pwd)/lib/Calulo_horas_con_conversion_segundos && Start_time-End_time ['PARAMETRO_$1'] ['PARAMETRO_$2']
#       PARAMETRO_$1_$2 'YYYY-MM-DD HH:MM:SS'
#       function '2022-12-2 00:05:44' '2022-12-2 00:10:57'
#
#DESCRIPTION
#        Calulo_horas_con_conversion_segundos script que incorpora funciones destinadas adherirse a 
#		 programas externos para agregarle la funcionalidad de restar tiempos de forma precisa.


#Tiempo Unix (timetamps)
#El tiempo Unix (también conocido como tiempo POSIX o tiempo Epoch) es un sistema para describir instantes en el tiempo,
#definido como el número de segundos que han transcurrido desde las 00:00:00 hora universal coordinada (UTC)
#3 el jueves 1 de enero de 1970, no contando los segundos bisiestos.
#Se usa ampliamente en sistemas operativos y formatos de archivo similares a Unix y muchos otros.
#Debido a que no maneja segundos bisiestos, no es una representación lineal del tiempo ni una representación real de UTC.


function  Start_time-End_time {
	#funcion principal encargada de tomar los datos y procesarlos
	local Start_time=$1
	local End_time=$2
 
	function verifica_contenido_vars_START_END {
		#Verifica que las variables Start_time y End_time tengan un valor almacenado 		
		if [[ -z ${Start_time} ]];then
			echo "Error, valor no identiciado en Start_time=${Start_time}?" 1>&2 && unset End_time
		fi 	

		if [[ -z ${End_time} ]];then
			echo "Error, valor no identiciado en End_Time=${End_time}?" 1>&2 && unset Start_time
		fi 	
	}

	function convertidor_yyyy_mm_dd_HH_MM_SS_timestamps {
		#convierte el contenido de las variables start y end en segundos
		verifica_contenido_vars_START_END
		 timestamps_Start_time=$(date -u --date "${Start_time}" +%s)
		 timestamps_End_time=$(date -u --date "${End_time}" +%s)
	}

	function verifica_timestamps_esten_correctos {
		#verifica que la variable timestamps_End_time sea mayor a timestamps_Start_time  
		convertidor_yyyy_mm_dd_HH_MM_SS_timestamps
		if [[ ${timestamps_End_time} -lt ${timestamps_Start_time} ]];then
 			echo -e "Error tiempo incorrecto\n${timestamps_Start_time} ${Start_time}\n${timestamps_End_time} ${End_time}" 1>&2
		fi 	
	}

	function resta_timestamps {
		#resta los segundos
		verifica_timestamps_esten_correctos
		 Segundos_timestamps_star_end="$(( ${timestamps_End_time}-${timestamps_Start_time} ))"
	}

	function convierte_timestamps_en_formato_YYYY_MM_DD_HH_MM_SS {
		#convierte los segundos a una hora legible en este caso HH_MM_SS favor leer más sobre el bug de la versión 1.0.000 más arriba
		resta_timestamps
		date -u -d @${Segundos_timestamps_star_end} '+%T'
		
	} 

	convierte_timestamps_en_formato_YYYY_MM_DD_HH_MM_SS
}