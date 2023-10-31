#' module_name UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_module_name_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' module_name Server Functions
#'
#' @noRd 
mod_module_name_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_module_name_ui("module_name_1")
    
## To be copied in the server
# mod_module_name_server("module_name_1")
