#include "../../utils/gnl_test.h"

int	main(int ac, char **av)
{
	if (ac == 1) { ft_putendl_fd("no input file given", 1); return (0); }
	
	char *line;
	int ret;
	int t;
	int fd;

	fd = open(av[1], O_RDONLY);
	ret = 1;
	t = 0;
	while ((ret = get_next_line(fd, &line)))
	{
		printf("[%d] %s\n", ret, line);
		if (ret == -1)
			return (0);
		t += ret;
		free(line);
	}
	printf("[%d] %s\n", ret, line);
		if (ret == -1)
			return (0);
		t += ret;
		free(line);
	
	printf("=== Count === %d\n", t);
	
	printf("=== Rappel apres avoir atteint la fin de fichier ===\n");
	ret = get_next_line(fd, &line);
	printf("[%d] %s\n", ret, line);
	free(line);

	close(fd);
}

/*
** if last line is some chrs then \n then EOF, have to return 1 and set the line
** if last line is some chrs then EOF, have to return 0 and set the line
** if gnl is recalled after read finished, have to return 0 and empty line
** if BUFFER_SIZE is 0, have to return 0
** if BUFFER_SIZE is negative, have to return -1
** if fd is negative or line is null or fd is invalid, have to return -1
**
** random tests : must not crash
** ./a.out /dev/random
** ./a.out /dev/null
** ./a.out /dev/zero
*/
