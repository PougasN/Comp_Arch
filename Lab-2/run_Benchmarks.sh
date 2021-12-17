#!/bin/bash

error="ERROR: wrong arguments
Try 'bash run_benchmarks.sh setup.ini'"

if [[ $# < 1 ]]; then
    echo "$error"
    exit 1
fi

SCRIPT="configs/example/se.py"
SCRIPTFLAGS="--cpu-type=MinorCPU --caches --l2cache"
Cache_line=$(awk -F "=" '/line/ {printf " "$2}' $1)
L1_d_size=$(awk -F "=" '/L1_d_size/ {printf " "$2}' $1)
L1_d_assoc=$(awk -F "=" '/L1_d_assoc/ {printf " "$2}' $1)

L1_i_size=$(awk -F "=" '/L1_i_size/ {printf " "$2}' $1)
L1_i_assoc=$(awk -F "=" '/L1_i_assoc/ {printf " "$2}' $1)

L2_size=$(awk -F "=" '/L2_size/ {printf " "$2}' $1)
L2_assoc=$(awk -F "=" '/L2_assoc/ {printf " "$2}' $1)
INSTCAP=100000000

RESULT_DIR=$(awk -F "=" '/res_dir/ {printf $2}' $1)
CMD=$(awk -F "=" '/cmd/ {printf $2}' $1)
OPTIONS=$(awk -F "=" '/options/ {printf $2}' $1)



out_dir=$RESULT_DIR/Benchmarks
mkdir $out_dir
touch $out_dir/read_config.ini
echo "[Benchmarks]"> $RESULT_DIR/Benchmarks/read_config.ini

for c in $Cache_line; do
for i in $L1_d_size; do
	for j in $L1_d_assoc; do
		for k in $L1_i_size; do
			for l in $L1_i_assoc; do	
				for m in $L2_size; do
					for n in $L2_assoc; do
						out_dir=$RESULT_DIR/Benchmarks/"$c"_"$i"_"$j"_"$k"_"$l"_"$m"_"$n"
						echo  "$out_dir">> $RESULT_DIR/Benchmarks/read_config.ini
						./build/ARM/gem5.opt -d $out_dir 		\
									$SCRIPT $SCRIPTFLAGS 	\
								     --l1d_size=$i		\
								     --l1i_size=$k		\
								     --l2_size=$m		\
								     --l1d_assoc=$j		\
								     --l1i_assoc=$l		\
								     --l2_assoc=$n 		\
								     --cacheline_size=$c	\
				     				     -c $CMD 			\
			 			 	  	     -o "$OPTIONS" 		\
  		 	     					     -I $INSTCAP
						

					done
				done
			
			done
		done
	done
done
done

echo -e  \
"\n[Parameters]
system.cpu.cpi
system.cpu.dcache.overall_miss_rate::total
system.cpu.icache.overall_miss_rate::total
system.l2.overall_miss_rate::total"						>> $RESULT_DIR/Benchmarks/read_config.ini

echo -e  \
"\n[Output]
results.txt"									>> $RESULT_DIR/Benchmarks/read_config.ini

bash read_results.sh $RESULT_DIR/Benchmarks/read_config.ini


exit 0
