#include "get_next_line.h"
#include <fcntl.h>
#include <stdio.h>

int	main(int ac, char **av)
{
	if (ac == 1) { ft_putendl_fd("no input file given", 1); return (0); }
	
	char *line;
	int ret;
	int t;
	int fd;
	int i = 1;

	while (av[i])
	{
		printf("\n[[[[[ %s ]]]]]\n\n", av[i]);
		fd = open(av[i], O_RDONLY);
		ret = 1;
		t = 0;
		while ((ret = get_next_line(fd, &line)))
		{
			printf("[%d] %s\n", ret, line);
			free(line);
			if (ret == -1)
				return (0);
			t += ret;
		}
		printf("[%d] %s\n", ret, line);
			free(line);
			if (ret == -1)
				return (0);
			t += ret;
	
		printf("=== Count === %d\n", t);
	
		printf("=== Rappel apres avoir atteint la fin de fichier ===\n");
		ret = get_next_line(fd, &line);
		printf("[%d] %s\n", ret, line);
		free(line);

		close(fd);
		i++;
	}
}
