volcano <- readr::read_rds(here::here("data", "volcanoes.rds"))

library(tidyverse)
library("rnaturalearth")
library("rnaturalearthdata")
library("sf")

world <- ne_countries(scale='medium',returnclass = 'sf')
class(world)
world %>% glimpse

# just continents?
just_continents <- world %>% 
  group_by(continent) %>% 
  summarize(geometry = sf::st_combine(geometry))


volcano %>% glimpse



volcano_sf <- volcano %>% 
  sf::st_as_sf(., coords = c("latitude", "longitude"))

st_crs(volcano_sf) <- sf::st_crs(just_continents)


volcano_and_continent <- just_continents %>% 
  rename(ne_continent = continent) %>% 
  st_join(volcano_sf)

volcano$continent %>% unique

nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
ggplot(just_continents) + 
  geom_sf(aes(fill = continent))
