/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_bonus.h                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: grochefo <grochefo@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/12/16 10:21:32 by grochefo          #+#    #+#             */
/*   Updated: 2019/12/16 16:26:35 by grochefo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_BONUS_H
# define GET_NEXT_LINE_BONUS_H

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
void				ft_lstdel(t_lstfd **alst, t_lstfd *svg);
#endif
