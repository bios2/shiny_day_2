#' plot_selection UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_plot_selection_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("plot"), hover = ns("plot_click"))
  )
}
    
#' plot_selection Server Functions
#'
#' @noRd 
mod_plot_selection_server <- function(id, count_volcanism){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    output$plot <- renderPlot({
      count_volcanism %>% 
        ggplot(aes(x = volcano_type_consolidated, y = n)) + 
        geom_point(size = 6) + 
        theme_bw()
    })
    
    clicked_lines <- reactive({
      req(input$plot_click)
      # browser()
      nearPoints(count_volcanism, input$plot_click)
    })
    
    return(clicked_lines)
  })
}
    
## To be copied in the UI
# mod_plot_selection_ui("plot_selection_1")
    
## To be copied in the server
# mod_plot_selection_server("plot_selection_1")
