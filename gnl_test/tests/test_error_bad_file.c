#include "../../utils/gnl_test.h"

int	main(int ac, char **av)
{
	if (ac == 1) { ft_putendl_fd("no input file given", 1); return (0); }

	int ret;
	char *line;
	int fd;

	fd = open(av[1], O_WRONLY);
	close(fd);
	ret = 1;
	ret = get_next_line(fd, &line);
	free(line);
	printf("[%d]", ret);
}
