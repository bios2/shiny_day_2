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

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("volcano data"),
    plotOutput("volcanoplot", click = "plot_click"),
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
        
    
    output$volcanoplot <- renderPlot({
        count_volcanism %>% 
            ggplot(aes(x = volcano_type_consolidated, y = n)) + 
            geom_point(size = 6) + 
            theme_bw()
    })
    
    output$data <- renderTable({
        req(input$plot_click)
        # browser()
        nearPoints(count_volcanism, input$plot_click)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
