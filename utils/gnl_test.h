#ifndef GNL_TEST_H
# define GNL_TEST_H

#include "../../rendu_gnl/get_next_line.h"
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>

void			ft_putnbr_fd(int n, int fd);
void			ft_putstr_fd(const char *s, int fd);
void			ft_putendl_fd(char const *s, int fd);

#endif
