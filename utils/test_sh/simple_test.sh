#!/bin/bash


###############
# SIMPLE_TEST #
###############

	echo "###############\n# SIMPLE_TEST #\n###############\n" > results/simple_test_folder/$3
	echo "${4}" >> results/simple_test_folder/$3
	PROJECT='project.a'
	GET_NEXT_LINE_FILES="${1}get_next_line.c ${1}get_next_line_utils.c"
	OBJ="get_next_line.o get_next_line_utils.o"
	gcc -Wall -Wextra -Werror -D BUFFER_SIZE=$2 -c $GET_NEXT_LINE_FILES
	ar rc utils/$PROJECT $OBJ
	ranlib utils/$PROJECT
	rm $OBJ				
	ret1='\033[1;31m[KO]\033[0m'
	ret2='\033[1;31m[KO]\033[0m'
	ret3='\033[1;31m[KO]\033[0m'
	ret4='\033[1;31m[KO]\033[0m'
	gcc -Wall -Werror -Wextra -g3 -o extest utils/$PROJECT gnl_test/tests/test_simple.c gnl_test/gnl_test_utils.c

	##############
	# SHAKESPEAR #
	##############

	echo "##############\n# SHAKESPEAR #\n##############\n" > results/simple_test_folder/simple_test
	echo "$(valgrind --log-file=valou ./extest tests_files/shakespear.txt)" >> results/simple_test_folder/simple_test
	grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
	rm -rf valou
	if cmp -s results/simple_test_folder/simple_test results/simple_test_folder/simple_test_corr_1
	then
		ret1='\033[1;32m[OK]\033[0m'
	fi
	if ! cmp -s utils/no_leaks utils/maybe_leaks
	then
		ret1="\033[1;31m/!\\\\\033[0m${ret1}"
	fi

	echo "$(cat results/simple_test_folder/simple_test)\n" >> results/simple_test_folder/$3

	##############
	# EMPTY FILE #
	##############

	echo "##############\n# EMPTY FILE #\n##############\n" > results/simple_test_folder/simple_test
	echo "$(valgrind --log-file=valou ./extest tests_files/empty_file.txt)" >> results/simple_test_folder/simple_test
	grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
	rm -rf valou
	if cmp -s results/simple_test_folder/simple_test results/simple_test_folder/simple_test_corr_2
	then
		ret2='\033[1;32m[OK]\033[0m'
	fi
	if ! cmp -s utils/no_leaks utils/maybe_leaks
	then
		ret2="\033[1;31m/!\\\\\033[0m${ret2}"
	fi

	echo "$(cat results/simple_test_folder/simple_test)\n" >> results/simple_test_folder/$3

	################
	# FOLLOWING BN #
	################

	echo "################\n# FOLLOWING BN #\n################\n" > results/simple_test_folder/simple_test
	echo "$(valgrind --log-file=valou ./extest tests_files/empty_file.txt)" >> results/simple_test_folder/simple_test
	grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
	rm -rf valou
	if cmp -s results/simple_test_folder/simple_test results/simple_test_folder/simple_test_corr_3
	then
		ret3='\033[1;32m[OK]\033[0m'
	fi
	if ! cmp -s utils/no_leaks utils/maybe_leaks
	then
		ret3="\033[1;31m/!\\\\\033[0m${ret3}"
	fi

	echo "$(cat results/simple_test_folder/simple_test)\n" >> results/simple_test_folder/$3

	# ###################################
	#  1000 LINE OF 1 CHAR ENDING : BN  #
	# ###################################

	echo "###################################\n# 1000 LINE OF 1 CHAR ENDING : BN #\n###################################\n" > results/simple_test_folder/simple_test
	echo "$(valgrind --log-file=valou ./extest tests_files/1000_lines_of_1_char_ending_with_bn.txt)" >> results/simple_test_folder/simple_test
	grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
	rm -rf valou
	if cmp -s results/simple_test_folder/simple_test results/simple_test_folder/simple_test_corr_4
	then
		ret4='\033[1;32m[OK]\033[0m'
	fi
	if ! cmp -s utils/no_leaks utils/maybe_leaks
	then
		ret4="\033[1;31m/!\\\\\033[0m${ret4}"
	fi

	echo "$(cat results/simple_test_folder/simple_test)\n" >> results/simple_test_folder/$3

	rm -rf utils/project.a extest extest.dSYM results/simple_test_folder/simple_test
	echo "simple_test buffer[\033[1;33m${2}\033[0m]: ${ret1} ${ret2} ${ret3} ${ret4}"