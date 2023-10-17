
install.packages("sunburstR")

library(tidyverse)
library(sunburstR)

# install plotly & dplyr
# install.packages(c("plotly", "dplyr"))

# load plotly & dplyr
library(plotly)
library(dplyr)


# test
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/718417069ead87650b90472464c7565dc8c2cb1c/coffee-flavors.csv")

fig <- df |> 
  plot_ly(
    type = "sunburst",
    ids = ~ids,
    labels = ~labels,
    parents = ~parents,
    domain = list(column = 1),
    maxdepth = 2,
    insidetextorientation = "radial"
  )

fig


labels <- c("Andy", "John", "Megan", "Tom", "Naomi", "Matt", "Florence", "Harry", "Sam")
parents <- c("", "Andy", "Andy", "Megan", "Megan", "Andy", "Andy", "Florence", "Andy")
values <- c(20,34,25,20,8,15,15,9,9)

fig <- plot_ly(
  type = "sunburst",
  labels = labels,
  parents = parents,
  values = values
)

fig


# install.packages("plotme")
#install.packages("remotes")
remotes::install_github("yogevherz/plotme")

# test_bio <- bioink_split3 %>%
#   mutate(typeNatural_level2 = replace(typeNatural_level2, typeGeneral_level1!="Natural", NA), 
#          typeSynthetic_level2 = replace(typeSynthetic_level2, typeGeneral_level1!="Synthetic", NA), 
#          
#          typeProtein_level3 = replace(typeProtein_level3, typeNatural_level2!="Protein based", NA), 
#          typePoly_level3 =  replace(typePoly_level3, typeNatural_level2!="Polysaccharide based", NA)
#   )


library(dplyr)
library(plotme)
starwars_count <- count(starwars, species, eye_color, name)



bioInk_count <-  count(test_bio, typeGeneral_level1, 
                       typeNatural_level2,
                       typeSynthetic_level2, 
                       typeProtein_level3,
                        typePoly_level3, 
                       study_ID)
                       # , 
                       #             typeNatural_level2, 
                       #             typeSynthetic_level2, 
                       #             
                       #             typePoly_level3)


# sunburst plot
count_to_sunburst(bioInk_count)

# fill by group size
count_to_sunburst(bioInk_count, fill_by_n = TRUE)

# treemap plot, ordered by group size
count_to_treemap(bioInk_count, sort_by_n = TRUE)

# display al charchaters by homeworld
starwars %>%
  count(homeworld, name) %>%
  count_to_treemap(sort_by_n = TRUE)

