library(shiny)
library(tidyverse)
library(magrittr)

# Define UI
ui <- fluidPage(
  h1("Price Predictor"),
  br(),
  fluidRow(
    column(6, numericInput("petrol_liquid_used", label = "Petrol Liquid Used", value = 500, min = 0, max = 1000)),
    column(6, numericInput("petrol_coke_used", label = "Petrol Coke Used", value = 500, min = 0, max = 1000))
  ),
  fluidRow(
    column(6, numericInput("natural_gas_used", label = "Natural Gas Used", value = 500, min = 0, max = 1000)),
    column(6, numericInput("vix", label = "VIX", value = 50, min = 0, max = 100))
  ),
  fluidRow(
    column(6, numericInput("avg_weather", label = "Avg Weather", value = 15, min = -20, max = 50))
  ),
  br(),
  actionButton("submit", "Submit"),
  br(),
  verbatimTextOutput("predicted_price")
)

# Define server
server <- function(input, output) {
  output$predicted_price <- renderPrint({
    req(input$submit)
    avg_eprice <- 8.770 + 6.026e-05 * input$petrol_liquid_used - 1.497e-03 * input$petrol_coke_used + 1.956e-06 * input$natural_gas_used + 1.635e-02 * input$vix + 8.380e-03 * input$avg_weather
    paste("Predicted Price: $", round(avg_eprice, 2))
  })
}

# Run the app
shinyApp(ui = ui, server = server)
