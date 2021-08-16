#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Volcanoes"),
    plotOutput("count_plot", click = "plot_click"),
    tableOutput("clicked_data")

)

# Define server logic required to draw a histogram
server <- function(input, output) {

    volcano <- readRDS(here::here("data", "volcanoes.rds"))

    volcano_counts <- volcano %>%
        group_by(volcano_type_consolidated) %>%
        tally %>%
        mutate(volcano_type_consolidated = forcats::fct_reorder(volcano_type_consolidated, desc(n)))

    output$count_plot <- renderPlot({
        volcano_counts %>%
            ggplot(aes(x = volcano_type_consolidated, y = n)) +
            geom_point(size = 6)
    })

    # observeEvent(input$plot_click, {cat("you clicked the plot!")})

    output$clicked_data <- renderTable({
        req(input$plot_click)
        # browser()
        nearPoints(volcano_counts, coordinfo = input$plot_click)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
