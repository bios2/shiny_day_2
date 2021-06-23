#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
source(here::here("R", "mod_plot_selection.R"))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("volcano data"),
    mod_plot_selection_ui("plot_selection_1"),
    tableOutput("data")

)

# Define server logic required to draw a histogram
server <- function(input, output) {

    volcano <- readRDS(here::here("data", "volcanoes.rds"))
    
    count_volcanism <- volcano %>% 
        group_by(volcano_type_consolidated) %>% 
        tally %>% 
        ungroup %>% 
        mutate(volcano_type_consolidated = 
                   fct_reorder(volcano_type_consolidated, desc(n)))
        
    
    tablepoints <- mod_plot_selection_server("plot_selection_1",
                                             count_volcanism = count_volcanism)
    
    output$data <- renderTable({
        # browser()
        tablepoints()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
