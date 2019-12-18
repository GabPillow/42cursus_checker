/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: grochefo <grochefo@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/10 16:57:23 by grochefo          #+#    #+#             */
/*   Updated: 2019/12/16 15:20:33 by grochefo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"

static t_lstfd	*ft_manage_lst(t_lstfd *st, int fd)
{
	t_lstfd	*new;

	while (st && st->fd != fd && st->next)
		st = st->next;
	if (st && st->fd == fd)
		return (st);
	if (!(new = ft_calloc(1, sizeof(t_lstfd))))
		return (NULL);
	if (!(new->buff = (char*)ft_calloc(BUFFER_SIZE + 1, sizeof(char))))
		return (NULL);
	new->svg = new->buff;
	new->fd = fd;
	st ? st->next = new : 0;
	return (new);
}

static char		*ft_reset_buff(char *buff, char *svg)
{
	int	i;

	i = 0;
	buff = svg;
	while (i++ < BUFFER_SIZE)
		*buff++ = 0;
	return (svg);
}

static void		putlst(t_lstfd *st)
{
	if (!st)
		printf("NULL\n");
	while (st)
	{
		printf("buff : %s\n", st->buff);
		printf("svg : %s\n", st->svg);
		printf("fd : %d\n", st->fd);
		st = st->next;
	}
}

int				get_next_line(const int fd, char **line)
{
	static t_lstfd		*st = NULL;
	t_lstfd				*sv;

	sv = st;
	if (!line || BUFFER_SIZE < 0 || !(st = ft_manage_lst(st, fd)) ||
	read(fd, st->buff, 0) == -1 ||
	(!(*line = (char*)ft_calloc(1, sizeof(char)))))
		return (-1);
	while (*st->buff || read(fd, st->buff, BUFFER_SIZE))
	{
		*line = ft_strjoinspe(*line, &st->buff);
		if (*st->buff == '\n')
		{
			st->buff++;
			if (!*st->buff)
				st->buff = ft_reset_buff(st->buff, st->svg);
			sv ? st = sv : 0;
			return (1);
		}
		st->buff = ft_reset_buff(st->buff, st->svg);
	}
	// printf("before :\n");
	// putlst(sv);
	ft_lstdel(&st, &sv);
	sv ? st = sv : 0;
	printf("after :\n");
	putlst(st);
	return (0);
}
