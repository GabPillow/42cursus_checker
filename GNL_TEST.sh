#!/bin/bash

############
# Menu #
############
ret='42'

while [ $ret != "0" ]
do

	sh utils/aff_menu.sh
	read ret

	if [ $ret == "a" ]
	then
		sh utils/path_project.sh
	fi
	PATH_GNL="$(cat utils/PATH_GNL)"
	if [ $ret == "b" ]
	then
		sh utils/buffer_size.sh
	fi
	BUFFER_SIZE="$(cat utils/buffer_size)"

#########
# TESTS #
#########

	if [ $ret == "1" ] || [ $ret == "2" ] || [ $ret == "3" ] || [ $ret == "4" ]
	then
		
		##############
		# NORMINETTE #
		##############

		NORM='\033[1;32m[OK]\033[0m 😺'
		TEST="$(norminette ${PATH_GNL} | grep "Warning\|Error")"
		if [ "$TEST" != "" ]
		then
			NORM="\033[1;31m[KO]\033[0m 🙀"
		fi
		echo "Norminette : ${NORM}"

		PROJECT='project.a'
		GET_NEXT_LINE_FILES="${PATH_GNL}get_next_line.c ${PATH_GNL}get_next_line_utils.c"
		OBJ="get_next_line.o get_next_line_utils.o"
		gcc -Wall -Wextra -Werror -D BUFFER_SIZE=$BUFFER_SIZE -c $GET_NEXT_LINE_FILES
		ar rc utils/$PROJECT $OBJ
		ranlib utils/$PROJECT
		rm $OBJ

		###############
		# SIMPLE_TEST #
		###############

		if [ $ret == "1" ] || [ $ret == "2" ]
		then
			ret1='\033[1;31m[KO]\033[0m'
			ret2='\033[1;31m[KO]\033[0m'
			ret3='\033[1;31m[KO]\033[0m'
			gcc -Wall -Werror -Wextra -g3 -o extest utils/$PROJECT gnl_test/tests/test_simple.c gnl_test/gnl_test_utils.c

		##############
		# SHAKESPEAR #
		##############

			echo "##############\n# SHAKESPEAR #\n##############\n" > results/simple_test_folder/simple_test_1
			/bin/echo -n "$(valgrind --log-file=valou ./extest tests_files/shakespear.txt)" >> results/simple_test_folder/simple_test_1
			grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
			rm -rf valou
			if cmp -s results/simple_test_folder/simple_test_1 results/simple_test_folder/simple_test_corr_1
			then
			ret1='\033[1;32m[OK]\033[0m'
			fi
			if ! cmp -s utils/no_leaks utils/maybe_leaks
			then
			ret1="\033[1;31m/!\\\\\033[0m${ret1}"
			fi

		# ###################################
		#  1000 LINE OF 1 CHAR ENDING : \n  #
		# ###################################

			echo "###################################\n# 1000 LINE OF 1 CHAR ENDING : \\\n #\n###################################\n" > results/simple_test_folder/simple_test_2
			/bin/echo -n "$(valgrind --log-file=valou ./extest tests_files/1000_lines_of_1_char_ending_with_bn.txt)" >> results/simple_test_folder/simple_test_2
			grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
			rm -rf valou
			if cmp -s results/simple_test_folder/simple_test_2 results/simple_test_folder/simple_test_corr_2
			then
			ret2='\033[1;32m[OK]\033[0m'
			fi
			if ! cmp -s utils/no_leaks utils/maybe_leaks
			then
			ret2="\033[1;31m/!\\\\\033[0m${ret2}"
			fi
		
		# ###########################################
		#  1 LINE of 100 000 CHAR CHAR ENDING : \n  #
		# ###########################################

			echo "###########################################\n# 1 LINE of 100 000 CHAR CHAR ENDING : \\\n #\n###########################################\n" > results/simple_test_folder/simple_test_3
			/bin/echo -n "$(valgrind --log-file=valou ./extest tests_files/4_lines_ending_with_bn.txt)" >> results/simple_test_folder/simple_test_3
			grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
			rm -rf valou
			if cmp -s results/simple_test_folder/simple_test_3 results/simple_test_folder/simple_test_corr_3
			then
			ret3='\033[1;32m[OK]\033[0m'
			fi
			if ! cmp -s utils/no_leaks utils/maybe_leaks
			then
			ret3="\033[1;31m/!\\\\\033[0m${ret3}"
			fi
			echo "Simple_test : ${ret1} ${ret2} ${ret3}"
		fi

		############
		# NO CRASH #
		############

		if [ $ret == "1" ] || [ $ret == "3" ]
		then
			ret1='\033[1;31m[KO]\033[0m'
			gcc -Wall -Werror -Wextra -g3 -o extest utils/$PROJECT gnl_test/tests/test_simple.c gnl_test/gnl_test_utils.c

			############
			# dev/null #
			############
			
			echo "#############\n# /dev/null #\n#############\n" > results/no_crash_folder/no_crash_1
			/bin/echo -n "$(valgrind --log-file=valou ./extest /dev/null)" >> results/no_crash_folder/no_crash_1
			grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
			rm -rf valou
			if cmp -s results/no_crash_folder/no_crash_1 results/no_crash_folder/no_crash_corr_1
			then
			ret1='\033[1;32m[OK]\033[0m'
			fi
			if ! cmp -s utils/no_leaks utils/maybe_leaks
			then
			ret1="\033[1;31m/!\\\\\033[0m${ret1}"
			fi
			echo "No_crash : ${ret1}"
		fi

		################
		# ERROR RETURN #
		################

		if [ $ret == "1" ] || [ $ret == "4" ]
		then
			ret1='\033[1;31m[KO]\033[0m'
			ret2='\033[1;31m[KO]\033[0m'
			ret3='\033[1;31m[KO]\033[0m'
			
			###########
			# NO LINE #
			###########

			echo "###########\n# NO LINE #\n###########\n" > results/error_return_folder/error_return_1
			gcc -Wall -Werror -Wextra -g3 -o nullos utils/$PROJECT gnl_test/tests/test_error_null.c gnl_test/gnl_test_utils.c
			/bin/echo -n "$(valgrind --log-file=valou ./nullos tests_files/shakespear.txt)" >> results/error_return_folder/error_return_1
			grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
			rm -rf valou
			if cmp -s results/error_return_folder/error_return_1 results/error_return_folder/error_return_corr_1
			then
			ret1='\033[1;32m[OK]\033[0m'
			fi
			if ! cmp -s utils/no_leaks utils/maybe_leaks
			then
			ret1="\033[1;31m/!\\\\\033[0m${ret1}"
			fi

			############
			# BAD FILE #
			############
			
			echo "############\n# BAD FILE #\n############\n" > results/error_return_folder/error_return_2
			gcc -Wall -Werror -Wextra -g3 -o nullos utils/$PROJECT gnl_test/tests/test_error_bad_file.c gnl_test/gnl_test_utils.c
			/bin/echo -n "$(valgrind --log-file=valou ./nullos tests_files/shakespear.txt)" >> results/error_return_folder/error_return_2
			grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
			rm -rf valou
			if cmp -s results/error_return_folder/error_return_2 results/error_return_folder/error_return_corr_2
			then
			ret2='\033[1;32m[OK]\033[0m'
			fi
			if ! cmp -s utils/no_leaks utils/maybe_leaks
			then
			ret2="\033[1;31m/!\\\\\033[0m${ret2}"
			fi

			#####################
			# WRONG BUFFER_SIZE #
			#####################

			echo "#####################\n# WRONG BUFFER_SIZE #\n#####################\n" > results/error_return_folder/error_return_3
			gcc -Wextra -Wall -g3 -o nullos -D BUFFER_SIZE=-1 $GET_NEXT_LINE_FILES gnl_test/tests/test_simple.c gnl_test/gnl_test_utils.c
			/bin/echo -n "$(valgrind --log-file=valou ./nullos tests_files/shakespear.txt)" >> results/error_return_folder/error_return_3
			grep "definitely lost" valou | cut -d: -f2 > utils/maybe_leaks
			rm -rf valou
			if cmp -s results/error_return_folder/error_return_3 results/error_return_folder/error_return_corr_3
			then
			ret3='\033[1;32m[OK]\033[0m'
			fi
			if ! cmp -s utils/no_leaks utils/maybe_leaks
			then
			ret3="\033[1;31m/!\\\\\033[0m${ret3}"
			fi

			echo "Error_return : ${ret1} ${ret2} ${ret3}"
			rm -rf nullos nullos.dSYM
		fi
	fi

	done
	rm -rf extest extest.dSYM