library(shiny)
shinyUI(  fluidPage(
    headerPanel("Map Your Data about China"),
    sidebarLayout(
      column(4,
        selectInput("var",
                    label="Choose the demo",
                    choices=c("Total population",
                              "Abroad Population",
                              "New Born in 2010",
                              "Average Housing Area (m2)",
                              "Use my own data"),
                    selected = "Total Population"),
        actionButton("reset_input","Reset Inputs"),
        uiOutput('resetable_input')),
      column(8,
        plotOutput(outputId="map",width="auto",height="800px")
      )
)))   
