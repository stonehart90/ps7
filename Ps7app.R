


library(shiny)
library(tidyverse)
ps7_data <- read_rds("ps7_data")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Voter Turnout Scale by Education"),
   
   # Sidebar with a select input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput(inputId = "educ",
                     label = "educ:" ,
                     choices = c("Grade school",
                                 "High school",
                                 "Some college or trade school",
                                 "Bachelors' degree",
                                 "Graduate or Professional Degree",
                                 "[DO NOT READ] Refused"))
                     
      
                   
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("responsePlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$responsePlot <- renderPlot({
    
     ps7_data %>% 
       filter(educ == input$educ) %>% 
      
        ggplot(aes(x = turnout_scale)) + 
       geom_histogram(binwidth = 1, na.rm = TRUE, stat = "count") + 
       labs(x = "turnout_scale",
            
              title = "Voter Turnout Scale Count by Education",
             caption = "Voter Turnout Scale by Education")
    
     
   })
}

# Run my application 
shinyApp(ui = ui, server = server)

