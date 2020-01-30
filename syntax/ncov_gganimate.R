
# load packages
library(tidyverse)
library(gganimate)

# create the data frmae
ncov_df <- data.frame(date = as.Date(c(rep("2020-01-21", 4),
                                       rep("2020-01-22", 4),
                                       rep("2020-01-23", 5),
                                       rep("2020-01-24", 7),
                                       rep("2020-01-25", 10),
                                       rep("2020-01-26", 11),
                                       rep("2020-01-27", 12),
                                       rep("2020-01-28", 15))),
                      country = c("China", "Japan", "Republic of Korea", "Thailand",
                                  "China", "Japan", "Republic of Korea", "Thailand",
                                  "China", "Japan", "Republic of Korea", "Thailand", "United States of America",
                                  "China", "Japan", "Republic of Korea", "Thailand", "Viet Nam", "Singapore", "United States of America",
                                  "China", "Japan", "Republic of Korea", "Viet Nam", "Singapore", "Australia", "Thailand", "Nepal", "United States of America", "France",
                                  "China", "Japan", "Republic of Korea", "Viet Nam", "Singapore", "Australia", "Malaysia", "Thailand", "Nepal", "United States of America", "France",
                                  "China", "Japan", "Republic of Korea", "Viet Nam", "Singapore", "Australia", "Malaysia", "Thailand", "Nepal", "United States of America", "Canada", "France",
                                  "China", "Japan", "Republic of Korea", "Viet Nam", "Singapore", "Australia", "Malaysia", "Cambodia", "Thailand", "Nepal", "Sri Lanka", "United States of America", "Canada", "France", "Germany"),
                      value = c(278, 1, 1, 2,
                                309, 1, 1, 2,
                                571, 1, 1, 4, 1,
                                860, 1, 2, 4, 2, 1, 4,
                                1297, 3, 2, 2, 3, 3, 4, 1, 2, 3,
                                1985, 3, 2, 2, 4, 4, 3, 5, 1, 2, 3,
                                2761, 4, 4, 2, 4, 4, 4, 5, 1, 5, 1, 3,
                                4537, 6, 4, 2, 7, 5, 4, 1, 14, 1, 1, 5, 2, 3, 1)) %>% 
  mutate(country.group = ifelse(country == "China", "China", "Other Countries"))
ncov_df

# create the static plot
p <- ggplot(ncov_df, aes(x = country, y = value, fill = country)) +
  geom_bar(stat = "identity", width = -0.25) +
  coord_flip() +
  theme_classic() +
  theme(legend.position = "bottom") +
  ylab("Confirmed cases") +
  xlab("Country") + 
  geom_text(aes(x = country, y = value, label = as.character(value)), hjust = 0.5) +
  labs(fill = "Country",
       caption = "Source: World Health Organization (WHO) - Situation Reports\n
       https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports\n
       Plot created by Hung Vo and for illustration purposes only\n
       Scales are not fixed") +
  facet_wrap( ~ country.group, ncol = 1, scales = "free")

# animate it
anim_ncov <- p +
  transition_time(date) +
  labs(title = "Confirmed Novel Coronavirus (2019-nCoV) cases: {frame_time}")
anim_ncov

# save it
anim_save("ncov.gif", anim_ncov)
