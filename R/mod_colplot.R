#' colplot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_colplot_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::textAreaInput(
          inputId = ns("peptide"),
          label = "Peptide sequence",
          width = 300,
          height = 100,
          placeholder = "AFGTSS"
        ),
        shiny::actionButton(
          inputId = ns("submit_btn"),
          label = "Submit"
        )
      ),
      shiny::mainPanel(
        shiny::plotOutput(
          outputId = ns("abundance")
        )

      )
    )
  )
}

#' colplot Server Functions
#'
#' @noRd
#' @importFrom ggplot2 theme
#' @import molecbio
mod_colplot_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(input$submit_btn, {
      output$abundance <- renderPlot({
        if(input$peptide == ""){
          return(NULL)
        } else{
          input$peptide |>
            molecbio::amino_acid_plot() +
            ggplot2::theme(legend.position = "none")
        }
      })
    })
  })
}

## To be copied in the UI
# mod_colplot_ui("colplot_1")

## To be copied in the server
# mod_colplot_server("colplot_1")
