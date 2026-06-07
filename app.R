library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Iris Flower Data"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("species", "Pick a Species:",
                  choices = c("All", "setosa", "versicolor", "virginica")),
      br(),
      p("Use the dropdown above to filter the charts by species.")
    ),
    
    mainPanel(
      h3("Sepal Length vs Sepal Width"),
      plotOutput("plot1"),
      br(),
      h3("Petal Length by Species"),
      plotOutput("plot2"),
      br(),
      h3("Distribution of Sepal Length"),
      plotOutput("plot3")
    )
  )
)

server <- function(input, output) {
  
  get_data <- reactive({
    if (input$species == "All") {
      iris
    } else {
      subset(iris, Species == input$species)
    }
  })
  
  output$plot1 <- renderPlot({
    ggplot(get_data(), aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point() +
      ggtitle("Sepal Length vs Width")
  })
  
  output$plot2 <- renderPlot({
    ggplot(get_data(), aes(x = Species, y = Petal.Length, fill = Species)) +
      geom_boxplot() +
      ggtitle("Petal Length by Species")
  })
  
  output$plot3 <- renderPlot({
    ggplot(get_data(), aes(x = Sepal.Length)) +
      geom_histogram(bins = 15, fill = "steelblue", color = "white") +
      ggtitle("Sepal Length Distribution")
  })
}

shinyApp(ui, server)
