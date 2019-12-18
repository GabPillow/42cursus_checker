/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_utils.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: grochefo <grochefo@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/16 19:52:00 by grochefo          #+#    #+#             */
/*   Updated: 2019/12/16 15:21:28 by grochefo         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"

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

void	ft_lstdel(t_lstfd **alst, t_lstfd **svg)
{
	if (*svg == *alst)
		*svg = NULL;
	ft_memdel((void**)(&(*alst)->buff));
	(*alst)->svg = NULL;
	(*alst)->fd = 0;
	ft_memdel((void*)(&(*alst)));
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
