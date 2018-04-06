library(shiny)
library(shinyWidgets)
source("chooseSliderSkin.R")
source("setSliderColor.R")

ui <- fluidPage(
  
  title = "setSliderColor/chooseSliderSkin demo",
  
  setSliderColor(c(
    "Aquamarine",
    "Coral",
    "Crimson", 
    "DeepPink ", 
    "Gold",
    "YellowGreen",
    "Orange",
    "Peru",
    "SlateBlue"
  ), c(1:9)),
  
  chooseSliderSkin("Flat"),
  
  fluidRow(
    column(
      4,
      sliderInput("obs1", "Slider Aquamarine Flat design:",
                  min = 0, max = 1000, value = 500
      ),
      sliderInput("obs2", "Slider Coral Flat design:",
                  min = 0, max = 1000, value = 500
      ),
      sliderInput("obs3", "Slider Crimson Flat design:",
                  min = 0, max = 1000, value = 500
      )
    ),
    column(
      4,
      sliderInput("obs4", "Slider DeepPink Flat design:",
                  min = 0, max = 1000, value = 500
      ),
      sliderInput("obs5", "Slider Gold Flat design:",
                  min = 0, max = 1000, value = 500
      ),
      sliderInput("obs6", "Slider YellowGreen Flat design:",
                  min = 0, max = 1000, value = 500
      )
    ),
    column(
      4,
      sliderInput("obs7", "Slider Orange Flat design:",
                  min = 0, max = 1000, value = 500
      ),
      sliderInput("obs8", "Slider Peru Flat design:",
                  min = 0, max = 1000, value = 500
      ),
      sliderInput("obs9", "Basic SlateBlue Flat design:",
                  min = 0, max = 1000, value = 500
      )
    )
  ),
  
  plotOutput("distPlot")
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)

