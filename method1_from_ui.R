library(shiny)
library(shinyWidgets)
source("chooseSliderSkin.R")
source("setSliderColor.R")
source("slider_colors.R")

ui <- fluidPage(
  
  title = "setSliderColor/chooseSliderSkin demo",
  
  titlePanel("Pimp your shiny sliders!"),
  
  setSliderColor(slider_colors, 1:length(slider_colors)),
  
  chooseSliderSkin("Flat"),
  
  br(), hr(),
  
  # create a set of 148 sliders
  # to test the 148 css colors
  fluidRow(
    lapply(0:3, FUN = function(j) {
      column(
        width = 3,
        lapply((1:37) + 37 * j, FUN = function(i) {
          tagList(
            sliderInput(
              inputId = paste0("slider", i), 
              label = paste("Slider", slider_colors[i], "Flat design:"),
              min = 0, max = 1, value = 0.5
            )
          )
        })
      )
    })
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)

