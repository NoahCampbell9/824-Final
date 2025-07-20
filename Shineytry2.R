# Load your dataset
data(lux.watch)

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Luxury Watches"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "Select Variable for X-axis:", 
                  choices = c("Brand", "Model", "CaseMaterial", "StrapMaterial", "MovementType", "DialColor")),
      selectInput("fillvar", "Select Variable for Fill:", 
                  choices = c("Brand", "Model", "CaseMaterial", "StrapMaterial", "MovementType", "DialColor"),
                  selected = NULL),
      checkboxInput("no_fill", "No Fill", value = FALSE)
    ),
    
    mainPanel(
      plotOutput("barplot")
    )
  )
)

server <- function(input, output) {
  output$barplot <- renderPlot({
    p <- ggplot(lux.watch, aes_string(x = input$xvar)) +
      geom_bar(aes_string(fill = ifelse(input$no_fill, "NULL", input$fillvar)), position = "dodge") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(x = input$xvar, fill = input$fillvar)
    
    print(p)
  })
}

shinyApp(ui = ui, server = server)