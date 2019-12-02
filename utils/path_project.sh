#!/bin/bash

####################
# ask path project #
####################

confirm='no'
while [ $confirm != "yes" ]
do
	echo "What is your path project ?"
	read PATH_GNL
	/bin/echo -n "$PATH_GNL" > utils/PATH_GNL
	echo "You enter \033[1;33m| ${PATH_GNL} |\033[0m\nIs this correct? Tap yes or no"
	read confirm
done

#######################
# gnl_test.h creation #
#######################

echo "#ifndef GNL_TEST_H
# define GNL_TEST_H

#include \"../${PATH_GNL}get_next_line.h\"
#include <unistd.h>
#include <stdlib.h>

void			ft_putnbr_fd(int n, int fd);
void			ft_putstr_fd(const char *s, int fd);
void			ft_putendl_fd(char const *s, int fd);

#endif" > utils/gnl_test.h
