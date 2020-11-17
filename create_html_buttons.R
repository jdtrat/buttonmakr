library(whisker)
library(tidyverse)
source('../metadata_functions.R')

websites <- c("https://www.eurekalert.org/pub_releases/2020-10/wfbm-srr100920.php", 
              "https://www.the-scientist.com/news-opinion/serotonin-and-dopamine-linked-to-decision-making-study-68050",
              "https://www.eurekalert.org/pub_releases/2019-05/wfbm-ssi052019.php",
              "https://www.wired.it/scienza/medicina/2020/10/14/cervello-serotonina-dopamina-decisioni/?refresh_ce=")

article_buttons <- map_chr(.x = websites, ~ get_metadata(.x) %>%
                             create_button_html()) %>% 
  str_flatten()

template <- readLines("../_news_template.html")
data <- list("article_buttons" = article_buttons)

writeLines(whisker.render(template, data), "layouts/partials/widgets/news.html")
