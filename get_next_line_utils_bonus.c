/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_utils_bonus.c                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: grochefo <grochefo@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/12/16 10:17:55 by grochefo          #+#    #+#             */
/*   Updated: 2019/12/16 17:14:41 by grochefo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line_bonus.h"

void	*ft_calloc(size_t nmemb, size_t size)
{
	void			*zm;
	unsigned char	*svg;
	size_t			n;

	n = size * nmemb;
	if (!(zm = malloc(size * nmemb)))
		return (NULL);
	svg = zm;
	while (n--)
		*svg++ = 0;
	return (zm);
}

void	ft_lstdel(t_lstfd **st, t_lstfd *svg)
{
	t_lstfd	*sv;

	sv = svg;
	if (sv->fd != )
	while ((sv->next)->fd != (*st)->fd)
		sv = sv->next;
	sv->next = (*st)->next;
	ft_memdel((void**)(&(*st)->buff));
	(*st)->svg = NULL;
	(*st)->fd = 0;
	ft_memdel((void*)(&(*st)));
}

void	ft_memdel(void **as)
{
	if (as)
	{
		free(*as);
		*as = NULL;
	}
}

char	*ft_strjoinspe(char *s1, char **s2)
{
	char *str_new;
	char *svg;
	char *svg1;

	str_new = NULL;
	svg1 = s1;
	if (!s1 && !s2)
		str_new = (char*)ft_calloc(1, sizeof(char));
	else
	{
		if (!(str_new = (char*)ft_calloc(ft_strlenn(s1) + ft_strlenn(*s2) +
		1, sizeof(char))))
			return (NULL);
		svg = str_new;
		while (s1 && *s1)
			*svg++ = *s1++;
		while (s2 && **s2 && **s2 != '\n')
			*svg++ = *((*s2)++);
		*svg = 0;
	}
	ft_memdel((void**)&svg1);
	return (str_new);
}

size_t	ft_strlenn(const char *s)
{
	size_t i;

	i = 0;
	if (s)
	{
		while (s[i] && s[i] != '\n')
			i++;
	}
	return (i);
}
