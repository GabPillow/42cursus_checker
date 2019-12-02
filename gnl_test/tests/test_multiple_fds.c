#include "get_next_line.h"
#include <fcntl.h>
#include <stdio.h>

int	main(int ac, char **av)
{
	if (ac == 1) { ft_putendl_fd("no input file given", 1); return (0); }
	if (ac < 4) { ft_putendl_fd("need 3 input files", 1); return (0); }
	
	char *line;
	int ret;
	int fd1;
	int fd2;
	int fd3;

	fd1 = open(av[1], O_RDONLY);
	fd2 = open(av[2], O_RDONLY);
	fd3 = open(av[3], O_RDONLY);

printf("***** CALL 1 *****\n");
	ret = get_next_line(fd1, &line);
	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[1]);
	printf("[%d] %s\n", ret, line);
	free(line);

	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[2]);
	ret = get_next_line(fd2, &line);
	printf("[%d] %s\n", ret, line);
	free(line);

	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[3]);
	ret = get_next_line(fd3, &line);
	printf("[%d] %s\n", ret, line);
	free(line);
printf("***** CALL 2 *****\n");
	ret = get_next_line(fd1, &line);
	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[1]);
	printf("[%d] %s\n", ret, line);
	free(line);

	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[2]);
	ret = get_next_line(fd2, &line);
	printf("[%d] %s\n", ret, line);
	free(line);

	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[3]);
	ret = get_next_line(fd3, &line);
	printf("[%d] %s\n", ret, line);
	free(line);
printf("***** CALL 3 *****\n");
	ret = get_next_line(fd1, &line);
	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[1]);
	printf("[%d] %s\n", ret, line);
	free(line);

	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[2]);
	ret = get_next_line(fd2, &line);
	printf("[%d] %s\n", ret, line);
	free(line);

	printf("[[[[[[[[[[ %s ]]]]]]]]]]\n", av[3]);
	ret = get_next_line(fd3, &line);
	printf("[%d] %s\n", ret, line);
	free(line);

	close(fd1);
	close(fd2);
	close(fd3);
}
