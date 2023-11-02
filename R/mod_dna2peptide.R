#' dna2peptide UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList fluidRow column verbatimTextOutput
mod_dna2peptide_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(8, shiny::uiOutput(ns("DNA")),
             shiny::actionButton(
               inputId = ns("generate_peptide"),
               label = "Peptide",
               style = "margin-top: 18px;"
             )),
      column(4,
             shiny::numericInput(
               inputId = ns("dna_length"),
               value = 6000,
               min = 3,
               max = 100000,
               step = 3,
               label = "Random DNA length"
             ),
             shiny::actionButton(
               inputId = ns("generate_dna"),
               label = "Generate random DNA",
               style = "margin-top: 18px;"
             )
      )
    ),
    shiny::verbatimTextOutput(outputId = ns("peptide")) |>
      shiny::tagAppendAttributes(style = "white-space: pre-wrap;")
  )
}

#' dna2peptide Server Functions
#'
#' @noRd
#' @import centralDogma
#'
mod_dna2peptide_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    dna <- reactiveVal()

    output$DNA <- renderUI({
      textAreaInput(
        inputId = ns("DNA"),
        label = "DNA sequence",
        placeholder = "Insert DNA sequence",
        value = dna(),
        height = 100,
        width = 600
      )
    })

    observeEvent(input$generate_dna, {
      dna(
        centralDogma::random_dna(input$dna_length)
      )
    })

    observeEvent(input$generate_peptide, {
      output$peptide <- renderText({
        input_dna <- input$DNA
        if (is.null(input_dna) || nchar(input_dna) < 3) {
          return(NULL)  # Return NULL if input is invalid
        }

        input_dna |>
          toupper() |>
          centralDogma::transcribe() |>
          centralDogma::codon_split() |>
          centralDogma::translate()
      })
    })
  })
}
