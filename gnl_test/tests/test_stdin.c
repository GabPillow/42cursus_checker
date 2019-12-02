#include "../../utils/gnl_test.h"
#include <fcntl.h>
#include <stdio.h>

int	main(void)
{
	char *line;
	int ret;
	int t;

	ret = 1;
	t = 0;
	while ((ret = get_next_line(0, &line)))
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
	ret = get_next_line(0, &line);
	printf("[%d] %s\n", ret, line);
	free(line);
}
