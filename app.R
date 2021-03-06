ui <- fluidPage(
  titlePanel("Shiny Text"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("rock", "pressure", "cars","iris", "usedcars", "heart")),
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 10)
    ),
    mainPanel(
      verbatimTextOutput("summary"),
      tableOutput("view")
    )
  )
)

server <- function(input, output) {
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars,
           "iris" = iris,
           "usedcars" = usedcars,
           "heart" = heart)
  })
  
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
}


shinyApp(ui = ui, server = server)
