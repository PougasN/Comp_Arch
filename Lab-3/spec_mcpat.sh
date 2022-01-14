#!/bin/bash

error="ERROR: wrong arguments
Try 'bash spec_mcpat.sh -p <print level>'"

if [[ $# < 2 ]]; then
    echo "$error"
    exit 1
fi

while test $# -gt 0; do
	case "$1" in
	-p|--print_level)
		shift
		if test $# -gt 0; then
			export PRINT_LVL=$1
		else
			echo "Using Default print level 1"
			PRINT_LVL=1
		fi
		shift
		;;
	*)
		break
		;;
	esac
done
	


XML_dir=$(find $PWD -maxdepth 1 -type d -name "spec_PDF")
mkdir -p $PWD/spec_mcpat_out
for dir in $XML_dir/*/ ; do
	
	res_dir=$(basename $dir)
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo $res_dir
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	mkdir -p spec_mcpat_out/$res_dir
	for x in $dir*.xml ; do 
		echo "McPAT input .xml file:"		
		echo $x
		out_file=$(basename $x .xml)
		./mcpat/mcpat	-infile $x  -print_level $PRINT_LVL  > "spec_mcpat_out"/$res_dir/$out_file.txt	
	done
done
