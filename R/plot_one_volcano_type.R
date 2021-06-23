
## comments for testing
# volcano <- readRDS(here::here("data", "volcanoes.rds"))
# 
# volcano %>% glimpse
# 
# library(tidyverse)


plot_one_volcano_type <- function(volcano_type_df){
  
  chosen_type <- volcano_type_df$volcano_type_consolidated
  
  volcano %>% 
    filter(volcano_type_consolidated == chosen_type) %>% 
    drop_na(last_eruption_year) %>% 
    group_by(volcano_type_consolidated) %>% 
    arrange(last_eruption_year) %>% 
    mutate(n_erupt = cumsum(!is.na(last_eruption_year))) %>% 
    ggplot(aes(x = last_eruption_year, y = n_erupt)) + geom_step() + 
    labs(title = paste0("Cumulative explosions of ", chosen_type, " Volcanoes"),
         x = "Years since eruption", y = "Eruptions") + 
    theme_bw()
}




# plot_one_volcano_type(volcano_type_df = data.frame(volcano_type_consolidated = "Cone"))
