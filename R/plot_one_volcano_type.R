
## comments for testing
# volcano <- readRDS(here::here("data", "volcanoes.rds"))
# 
# volcano %>% glimpse
# 
# library(tidyverse)


plot_one_volcano_type <- function(volcano_type_df, full_volcano_data){
  
  chosen_type <- volcano_type_df$volcano_type_consolidated
  
  plot_step_data <- full_volcano_data %>% 
    drop_na(last_eruption_year) %>% 
    group_by(volcano_type_consolidated) %>% 
    arrange(last_eruption_year) %>% 
    mutate(n_erupt = cumsum(!is.na(last_eruption_year))) %>% 
    ungroup
  
  plot_step_data %>% 
    ggplot(aes(x = last_eruption_year, y = n_erupt, group = volcano_type_consolidated)) + 
    geom_step() + 
    gghighlight(volcano_type_consolidated == chosen_type) +
    labs(title = paste0("Cumulative explosions of ", chosen_type, " Volcanoes"),
         x = "Years since eruption", y = "Eruptions") + 
    theme_bw()
}


plot_one_volcano_type(volcano_type_df = data.frame(volcano_type_consolidated = "Cone"),
                      full_volcano_data = readRDS(here::here("data", "volcanoes.rds")))
