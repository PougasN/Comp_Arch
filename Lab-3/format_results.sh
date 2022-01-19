#!/bin/bash

NRG_Dir=$(find /home/arch/Desktop -name "spec_energy" )
MCPAT_Dir=$(find /home/arch/Desktop -name "spec_mcpat_out")



for infile in $NRG_Dir/*.txt; do
	outfile=$(basename $infile  .txt )
	echo $outfile
	outfile=$outfile"_res.txt"
	echo "config	leakage	dynamic	runtime	energy"> $outfile
	config=($(grep -w "^.*_.*kB_.*_.*kB_.*_.*MB_.*$" $infile| cut -d " " -f 5| xargs -n 1 basename | cut -d "." -f 1))
	leakage=($(grep -w "leakage" $infile | cut -d " " -f 2))
	dynamic=($(grep -w "dynamic" $infile | cut -d " " -f 5))
	runtime=($(grep -w "runtime" $infile | cut -d " " -f 9))
	energy=($(grep -w "energy"   $infile | cut -d " " -f 3))
	for (( i=0; i<=${#leakage[@]}; i++ )); do 
		echo -e ${config[$i]}"\t"${leakage[$i]}"\t"${dynamic[$i]}"\t"${runtime[$i]}"\t"${energy[$i]}>> $outfile
	done
done
