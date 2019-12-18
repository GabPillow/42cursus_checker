/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.h                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: grochefo <grochefo@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/10 17:08:56 by grochefo          #+#    #+#             */
/*   Updated: 2019/12/16 14:37:36 by grochefo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_H
# define GET_NEXT_LINE_H

# include <unistd.h>
# include <stdlib.h>
# include <stdio.h>

typedef struct		s_lstfd
{
	char			*svg;
	char			*buff;
	int				fd;
	struct s_lstfd	*next;
}					t_lstfd;

int					get_next_line(int fd, char **line);
void				*ft_calloc(size_t nmemb, size_t size);
size_t				ft_strlenn(const char *s);
void				ft_memdel(void **as);
char				*ft_strjoinspe(char *s1, char **s2);
void				*ft_memcpy(void *dest, const void *src, size_t n);
void				ft_lstdel(t_lstfd **alst, t_lstfd **svg);
#endif
