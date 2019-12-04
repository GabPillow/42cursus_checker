#include "../../utils/gnl_test.h"

int	main(int ac, char **av)
{
	if (ac == 1) { ft_putendl_fd("no input file given", 1); return (0); }
	if (ac < 4) { ft_putendl_fd("need 3 input files", 1); return (0); }
	
	char *line;
	int ret1;
	int ret2;
	int ret3;
	int fd1;
	int fd2;
	int fd3;
	int call;

	fd1 = open(av[1], O_RDONLY);
	fd2 = open(av[2], O_RDONLY);
	fd3 = open(av[3], O_RDONLY);

	ret1 = 1;
	ret2 = 1;
	ret3 = 1;

	call = 1;

	while (ret1 || ret2 || ret3)
	{
		printf("***** CALL %d *****\n", call);
		ret1 = get_next_line(fd1, &line);
		printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[1]);
		printf("[%d] %s\n", ret1, line);
		free(line);

		printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[2]);
		ret2 = get_next_line(fd2, &line);
		printf("[%d] %s\n", ret2, line);
		free(line);

		printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[3]);
		ret3 = get_next_line(fd3, &line);
		printf("[%d] %s\n", ret3, line);
		free(line);
		call++;
	}

	close(fd1);
	close(fd2);
	close(fd3);
}
