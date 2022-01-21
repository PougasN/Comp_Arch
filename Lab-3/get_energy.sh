#!/bin/bash

PYSCRIPT="Scripts/print_energy.py"
GEM5_Dir=$(find /home/arch/Desktop -name "spec_results" )
MCPAT_Dir=$(find /home/arch/Desktop -name "spec_mcpat_out")

echo $GEM5_Dir
echo $MCPAT_Dir

mkdir -p $PWD/spec_energy

for mc_dir in $MCPAT_Dir/* ; do
	#echo $mc_dir
	new_dir=$(basename $mc_dir)
	echo -e "Benchmark:	"$new_dir
	new_dir=$PWD"/spec_energy/"$new_dir
	
	outfile=$new_dir".txt"
	touch  $outfile
	for x in $mc_dir/*.txt ; do
		temp=$(echo $x | cut -d '/' -f 7)
		
		g5_dir=$GEM5_Dir/$temp/"Benchmarks"
		temp=$(echo $x | cut -d '/' -f 8| cut -d '.' -f 1)
		#echo $temp >> $outfile
		g5_dir=$g5_dir/$temp/"stats.txt"

		python 	$PYSCRIPT	\
			-q		\
			$x		\
			$g5_dir>> $outfile
		echo " "    >> $outfile
			
	done

done
