#include "../../utils/gnl_test.h"

int	main(int ac, char **av)
{
	if (ac == 1) { ft_putendl_fd("no input file given", 1); return (0); }

	int ret;
	int fd;

	fd = open(av[1], O_RDONLY);
	ret = 1;
	ret = get_next_line(fd, NULL);
	printf("[%d]", ret);

	close(fd);
}
