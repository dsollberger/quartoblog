ui <- fluidPage(
  titlePanel("Bee Populations"),
  sidebarLayout(
    sidebarPanel(
      selectInput("chosen_state", "Select location", 
                  choices = US_states,
                  selected = "OTHER STATES")
    ),
    mainPanel(
      plotOutput(outputId = "beePlot")
    )
  )
)
server <- function(input, output) {
  filtered_data <- reactive({
    bee_df %>%
      filter(State == input$chosen_state)
  })
  
  output$beePlot <- renderPlot({
    filtered_data() %>%
      ggplot(aes(x = Year, y = Value)) +
      geom_bar(stat = "identity")
  })
}
shinyApp(ui = ui, server = server)
