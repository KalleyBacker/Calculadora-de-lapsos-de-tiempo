# Calculadora-de-lapsos-de-tiempo



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
