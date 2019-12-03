library(DT)
library(shiny)
library(rsconnect)
datadata <- read.csv('C:/Users/Administrator/Desktop/homework/data/mydata.csv',header=T)
server=function(input, output) {
    
    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        data <- datadata
        if (input$stock != "All") {
            data <- data[data$stock == input$stock,]
        }
        if (input$sector != "All") {
            data <- data[data$sector == input$sector,]
        }
        if (input$industry!= "All") {
            data <- data[data$industry == input$industry,]
        }
        data
    }))
    
}




ui=fluidPage(
    titlePanel("screener"),
    
    # Create a new Row in the UI for selectInputs
    fluidRow(
        column(4,
               selectInput("stock",
                           "stock:",
                           c("All",
                             unique(as.character(datadata$stock))))
        ),
        column(4,
               selectInput("sector",
                           "sector:",
                           c("All",
                             unique(as.character(datadata$sector))))
        ),
        column(4,
               selectInput("industry",
                           "industry:",
                           c("All",
                             unique(as.character(datadata$industry))))
        )
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table")
)

shinyApp(ui,server)

