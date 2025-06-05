
library(shiny)
library(shinythemes)


####################################
# User Interface                   #
####################################
ui <- fluidPage(
             navbarPage("BMI Calculator:", theme = shinytheme("united"),
                           
                           tabPanel("Home",
                                    # Input values
                                    sidebarPanel(
                                      HTML("<h3>Input parameters</h3>"),
                                      sliderInput("height", 
                                                  label = "Height", 
                                                  value = 175, 
                                                  min = 40, 
                                                  max = 250),
                                      sliderInput("weight", 
                                                  label = "Weight", 
                                                  value = 70, 
                                                  min = 20, 
                                                  max = 100),
                                      
                                      actionButton("submitbutton", 
                                                   "Submit", 
                                                   class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Status/Output')), # Status/Output Text Box
                                      verbatimTextOutput('contents'),
                                      tableOutput('tabledata') # Results table
                                    ) # mainPanel()
                                    
                           ), #tabPanel(), Home
                           
                           tabPanel("About", 
                                    titlePanel("About"), 
                                    div(
                                      HTML("
                                          <h3>About This Application</h3>
                                         <p>#### What is BMI?

**Body Mass Index (BMI)** is essentially a value obtained from the weight and height of a person [1].

#### Calculating the BMI
BMI can be computed by dividing the person's weight (kg) by their squared height (m) as follows:

> BMI = kg/m^2

where *kg* represents the person's weight and *m^2* the person's squared height.

#### About this BMI Calculator

This *BMI Calculator* is for adults 20 years and older. Further information on calculating BMI for children and teenagers is available from the CDC [2].

#### References
1. Centers for Disease Control. [Body Mass Index (BMI)](https://www.cdc.gov/healthyweight/assessing/bmi/index.html), Accessed January 26, 2020.
2. Centers for Disease Control. [BMI Percentile Calculator for Child and Teen](https://www.cdc.gov/healthyweight/bmi/calculator.html), Accessed January 26, 2020.
</p>
                                        "),
                                      align="justify"
                                    )
                           ) #tabPanel(), About
                           
                ) # navbarPage()
) # fluidPage()


####################################
# Server                           #
####################################
server <- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    bmi <- input$weight/( (input$height/100) * (input$height/100) )
    bmi <- data.frame(bmi)
    names(bmi) <- "BMI"
    print(bmi)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}


####################################
# Create Shiny App                 #
####################################
shinyApp(ui = ui, server = server)
