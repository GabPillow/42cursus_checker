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

#########
# TESTS #
#########

	if [ $ret == "1" ] || [ $ret == "2" ] || [ $ret == "3" ] || [ $ret == "4" ] || [ $ret == "5" ]
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

		###############
		# SIMPLE_TEST #
		###############

		if [ $ret == "1" ] || [ $ret == "2" ]
		then
			sh utils/test_sh/simple_test.sh ${PATH_GNL} 1 "test_buff_1" "###################\n# BUFFER_SIZE = 1 #\n###################\n"
			sh utils/test_sh/simple_test.sh ${PATH_GNL} 579 "test_buff_579" "#####################\n# BUFFER_SIZE = 579 #\n#####################\n"
			sh utils/test_sh/simple_test.sh ${PATH_GNL} 2024 "test_buff_2024" "######################\n# BUFFER_SIZE = 2024 #\n######################\n"
			sh utils/test_sh/simple_test_0.sh ${PATH_GNL} 0 "test_buff_0" "######################\n# BUFFER_SIZE = 0 #\n######################\n"
		fi

		############
		# NO CRASH #
		############

		if [ $ret == "1" ] || [ $ret == "3" ]
		then

			PROJECT='project.a'
			GET_NEXT_LINE_FILES="${PATH_GNL}get_next_line.c ${PATH_GNL}get_next_line_utils.c"
			OBJ="get_next_line.o get_next_line_utils.o"
			gcc -Wall -Wextra -Werror -D BUFFER_SIZE=50 -c $GET_NEXT_LINE_FILES
			ar rc utils/$PROJECT $OBJ
			ranlib utils/$PROJECT
			rm $OBJ

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
			rm -rf libft.a extest extest.dSYM
		fi

		################
		# ERROR RETURN #
		################

		if [ $ret == "1" ] || [ $ret == "4" ]
		then

			PROJECT='project.a'
			GET_NEXT_LINE_FILES="${PATH_GNL}get_next_line.c ${PATH_GNL}get_next_line_utils.c"
			OBJ="get_next_line.o get_next_line_utils.o"
			gcc -Wall -Wextra -Werror -D BUFFER_SIZE=1 -c $GET_NEXT_LINE_FILES
			ar rc utils/$PROJECT $OBJ
			ranlib utils/$PROJECT
			rm $OBJ

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
			rm -rf nullos nullos.dSYM libft.a extest extest.dSYM
		fi

		#########
		# BONUS #
		#########
		
		if [ $ret == "1" ] || [ $ret == "5" ]
		then
		sh utils/test_sh/multi_fd.sh ${PATH_GNL} 1 "test_buff_1" "###################\n# BUFFER_SIZE = 1 #\n###################\n" 113
		sh utils/test_sh/multi_fd.sh ${PATH_GNL} 579 "test_buff_579" "#####################\n# BUFFER_SIZE = 579 #\n#####################\n" 119
		sh utils/test_sh/multi_fd.sh ${PATH_GNL} 2024 "test_buff_2024" "######################\n# BUFFER_SIZE = 2024 #\n######################\n" 122
		fi
	fi

	done