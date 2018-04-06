

# Method 1 : choose skin in UI --------------------------------------------

# In this method, we define a skin in the UI
# This apply to all sliders in the app

# Todo : instead of recreating a complete dependency, use shiny's dep since all skins are available
# https://github.com/rstudio/shiny/tree/master/inst/www/shared/ionrangeslider/css




# Fun ---------------------------------------------------------------------

# # new function similar to bootstrapLib() of shiny
# # we use only shiny dependencies
# ionrangesliderLib <- function (skin) {
#   htmltools::htmlDependency(
#     "ionrangeslider", "2.1.6", 
#     c(href = "shared/ionrangeslider", 
#       file = system.file("www/shared/ionrangeslider", package = "shiny")
#     ), 
#     script = "js/ionrangeslider.min.js", 
#     stylesheet = c(
#       "css/ion.rangeSlider.css",
#       paste0("css/ion.rangeSlider.skin", skin, ".css"))
#   )
# }

sliderInputDep <- function(skin) {
  # recovers the dependencies 
  # of a normal sliderInput
  deps <- htmltools::findDependencies(
    sliderInput(
      inputId = "test", 
      label = "", 
      min = 0, max = 1000, value = 500
    )
  )
  # replace the css skin by what the user want
  # in chooseSliderSkin()
  deps[[1]]$stylesheet[[2]] <- paste0("css/ion.rangeSlider.skin", skin, ".css")
  return (deps)
}

chooseSliderSkin <- function(skin = c("Shiny", "Flat", "Modern", "Nice",
                                      "Simple", "HTML5", "Round", "Square")) {
  skin <- match.arg(arg = skin)
  tagList(
    #htmltools::suppressDependencies("ionrangeslider"),
    htmltools::attachDependencies(
      x = tags$div(),
      value = sliderInputDep(skin), 
      append = FALSE
    )
  )
}

# you can pick colors from here
# https://www.w3schools.com/colors/colors_names.asp
# sliderId can be a vector like c(0, 1, 2, ...)
# depending on what slider you want to
# customize
# color is also a vector depending on the number of sliders
setSliderColor <- function(color, sliderId) {
  
  # create custom css background for each slider
  # start from 0 so need to use i-1 for slider Id
  # instead of i
  sliderCol <- lapply(1:length(sliderId), FUN = function(i) {
      paste0(".js-irs-", i-1, " .irs-single,", 
             " .js-irs-", i-1, " .irs-bar-edge,",
             " .js-irs-", i-1, " .irs-bar{
             background: ", color[i], ";
  }"
      )
  })
  
  # insert this custom css code in the head
  # of the shiy app
  custom_head <- tags$head(tags$style(HTML(as.character(sliderCol))))
  return(custom_head)
}




# Demo --------------------------------------------------------------------


ui <- fluidPage(
  
  setSliderColor(c("yellow", "purple"), c(0, 1)),
  chooseSliderSkin("Modern"),
  sliderInput("obs", "Number of observations:",
              min = 0, max = 1000, value = 500
  ),
  sliderInput("obs2", "Number of observations:",
              min = 0, max = 1000, value = 500
  ),
  plotOutput("distPlot")
)

server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)
