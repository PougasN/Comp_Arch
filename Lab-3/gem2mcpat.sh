#!/bin/bash


PYSCRIPT="Scripts/GEM5ToMcPAT.py"
GEM5_Dir=$(find /home/arch/Desktop -name "spec_results" )
TEMPLATE_PATH="/home/arch/Desktop/mcpat/mcpat/ProcessorDescriptionFiles/inorder_arm.xml"

list=$(ls -rt -d -1 $GEM5_Dir/*)
echo $list
mkdir $PWD"/spec_PDF"
for d in $list ; do
	benchmark=$(find $d/Benchmarks -mindepth 1 -maxdepth 1 -type d)
	echo "-------------------------------------------------------"
	res_dir=$(echo $benchmark | cut -d '/' -f 7)
	mkdir spec_PDF/$res_dir
	for b in $benchmark; do
		xml_name=$(basename $b)
		echo $res_dir"/"$xml_name".xml"
		python 		$PYSCRIPT 				\
			-o      "spec_PDF/"$res_dir"/"$xml_name".xml"		\
				$b"/stats.txt"				\
				$b"/config.json"			\
				$TEMPLATE_PATH		
			
	done
done 
