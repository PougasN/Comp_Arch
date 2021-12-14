#!/bin/bash

OUTPUT_TXT="test_info.txt"
SCRIPT="configs/example/se.py"
SCRIPTFLAGS="--cpu-type=MinorCPU --caches --l2cache"
INSTCAP=100000

function get_stats(){
	echo -e "\n#General info"
	grep -w "sim_seconds" $1/stats.txt
	grep -w "sim_insts" $1/stats.txt
	grep -w "system.cpu.cpi" $1/stats.txt
	grep -w "system.cpu.committedInsts" $1/stats.txt
	grep -w "system.cpu.committedOps" $1/stats.txt
	#clk_domain	
	echo -e "\n#clk_domain"
	grep -w "system.clk_domain.clock" $1/stats.txt
	grep -w "system.cpu_clk_domain.clock" $1/stats.txt
	#L1.Data Cache
	echo -e "\n#L1.Data Cache"
	grep -w "system.cpu.dcache.overall_misses::total" $1/stats.txt
	grep -w "system.cpu.dcache.overall_miss_rate::total" $1/stats.txt
	grep -w "system.cpu.dcache.replacements" $1/stats.txt
	#L1.Instruction Cache
	echo -e "\n#L1.Instruction Cache"
	grep -w "system.cpu.icache.overall_misses::total" $1/stats.txt
	grep -w "system.cpu.icache.overall_miss_rate::total" $1/stats.txt
	#L2 Cache
	echo -e "\n#L2 Cache"
	grep -w "system.l2.overall_misses::total" $1/stats.txt
	grep -w "system.l2.overall_miss_rate::total" $1/stats.txt
	grep -w "system.l2.overall_accesses::total" $1/stats.txt
	
}


function get_config(){
	echo -e "\n#Congig Stats\n"
	sed  -n 15p  	$1/config.ini #cache_line_size
	
	sed  -n 159p 	$1/config.ini #l1_dcache assoc
	sed  -n 179p 	$1/config.ini #l1_dcache size
	
	sed  -n 793p 	$1/config.ini #l1_icache assoc
	sed  -n 813p 	$1/config.ini #l1_icache size
	
	sed  -n 998p 	$1/config.ini #l2_cache assoc
	sed  -n 1018p  	$1/config.ini #l2_cache size
}

#401.bzip2
RESULT_DIR_401="spec_results/specbzip"
CMD_401="spec_cpu2006/401.bzip2/src/specbzip"
OPTIONS_401="spec_cpu2006/401.bzip2/data/input.program 10"

#429.mcf
RESULT_DIR_429="spec_results/specmcf"
CMD_429="spec_cpu2006/429.mcf/src/specmcf"
OPTIONS_429="spec_cpu2006/429.mcf/data/inp.in"

#456.hmmer
RESULT_DIR_456="spec_results/spechmmer"
CMD_456="spec_cpu2006/456.hmmer/src/spechmmer"
OPTIONS_456="--fixed 0 --mean 325 --num 45000 --sd 200 --seed 0 spec_cpu2006/456.hmmer/data/bombesin.hmm"

#458.sjeng
RESULT_DIR_458="spec_results/specsjeng"
CMD_458="spec_cpu2006/458.sjeng/src/specsjeng"
OPTIONS_458="spec_cpu2006/458.sjeng/data/test.txt"

#470.libm
RESULT_DIR_470="spec_results/speclibm"
CMD_470="spec_cpu2006/470.lbm/src/speclibm"
OPTIONS_470="20 spec_cpu2006/470.lbm/data/lbm.in 0 1 spec_cpu2006/470.lbm/data/100_100_130_cf_a.of"


echo -n "">$OUTPUT_TXT
echo -e "~~~~~~~~~~~~~~~~~~SPEC_CPU2006 Benchmark CPU_FREQ=2GHz~~~~~~~~~~~~~~~~~~\n"
read -p "Press enter to continue..."



./build/ARM/gem5.opt -d $RESULT_DIR_401 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     -c $CMD_401 		\
 		     -o "$OPTIONS_401" 		\
  	 	     -I $INSTCAP

echo -e "\nSpecbzip~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats  $RESULT_DIR_401>>$OUTPUT_TXT
get_config $RESULT_DIR_401>>$OUTPUT_TXT

./build/ARM/gem5.opt -d $RESULT_DIR_429 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     -c $CMD_429 		\
 		     -o "$OPTIONS_429" 		\
  	 	     -I $INSTCAP

echo -e "\nSpecbmcf~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_429>>$OUTPUT_TXT
get_config $RESULT_DIR_429>>$OUTPUT_TXT

./build/ARM/gem5.opt -d $RESULT_DIR_456 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     -c $CMD_456 		\
 		     -o "$OPTIONS_456" 		\
  	 	     -I $INSTCAP

echo -e "\nSpechmmer~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_456>>$OUTPUT_TXT
get_config $RESULT_DIR_456>>$OUTPUT_TXT

./build/ARM/gem5.opt -d $RESULT_DIR_458 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     -c $CMD_458 		\
 		     -o "$OPTIONS_458" 		\
  	 	     -I $INSTCAP

echo -e "\nSpecsjeng~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_458>>$OUTPUT_TXT
get_config $RESULT_DIR_458>>$OUTPUT_TXT

./build/ARM/gem5.opt -d $RESULT_DIR_470 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     -c $CMD_470 		\
 		     -o "$OPTIONS_470" 		\
  	 	     -I $INSTCAP

echo -e "\nSpeclibm~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_470>>$OUTPUT_TXT
get_config $RESULT_DIR_470>>$OUTPUT_TXT

RESULT_DIR_401="spec_results/Freq15/specbzip"
RESULT_DIR_429="spec_results/Freq15/specmcf"
RESULT_DIR_456="spec_results/Freq15/spechmmer"
RESULT_DIR_458="spec_results/Freq15/specsjeng"
RESULT_DIR_470="spec_results/Freq15/speclibm"


echo -e "~~~~~~~~~~~~~~~~~~SPEC_CPU2006 Benchmark CPU_FREQ=1.5GHz~~~~~~~~~~~~~~~~~~\n\n"

echo -e "\n\n~~~~~~~~~~~~~~~~~~SPEC_CPU2006 Benchmark CPU_FREQ=1.5GHz~~~~~~~~~~~~~~~~~~\n\n">>$OUTPUT_TXT


./build/ARM/gem5.opt -d $RESULT_DIR_401 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     --cpu-clock=1.5GHz		\
		     -c $CMD_401 		\
 		     -o "$OPTIONS_401" 		\
  	 	     -I $INSTCAP

echo -e "\nSpecbzip~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_401>>$OUTPUT_TXT
get_config $RESULT_DIR_401>>$OUTPUT_TXT

./build/ARM/gem5.opt -d $RESULT_DIR_429 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     --cpu-clock=1.5GHz		\
		     -c $CMD_429 		\
 		     -o "$OPTIONS_429" 		\
  	 	     -I $INSTCAP

echo -e "\nSpecbmcf~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_429>>$OUTPUT_TXT
get_config $RESULT_DIR_429>>$OUTPUT_TXT

./build/ARM/gem5.opt -d $RESULT_DIR_456 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     --cpu-clock=1.5GHz		\
		     -c $CMD_456 		\
 		     -o "$OPTIONS_456" 		\
  	 	     -I $INSTCAP

echo -e "\nSpechmmer~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_456>>$OUTPUT_TXT
get_config $RESULT_DIR_456>>$OUTPUT_TXT

./build/ARM/gem5.opt -d $RESULT_DIR_458 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     --cpu-clock=1.5GHz		\
		     -c $CMD_458 		\
 		     -o "$OPTIONS_458" 		\
  	 	     -I $INSTCAP

echo -e "\nSpecsjeng~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_458>>$OUTPUT_TXT
get_config $RESULT_DIR_458>>$OUTPUT_TXT

./build/ARM/gem5.opt -d $RESULT_DIR_470 	\
			$SCRIPT $SCRIPTFLAGS 	\
		     --cpu-clock=1.5GHz		\
		     -c $CMD_470 		\
 		     -o "$OPTIONS_470" 		\
  	 	     -I $INSTCAP

echo -e "\nSpeclibm~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"	>>$OUTPUT_TXT
get_stats $RESULT_DIR_470>>$OUTPUT_TXT
get_config $RESULT_DIR_470>>$OUTPUT_TXT
