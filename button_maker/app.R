library(shiny)
library(buttonmakr)
library(whisker)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Create a button with meta data"),
        mainPanel(wellPanel(p("This app takes in a URL and generates an HTML button that contains the meta data for it which will open up the link when clicked.")),
           textInput("url", "Enter a URL"),
           uiOutput("button")
        )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$button <- renderUI({

        req(input$url)

        button <- buttonmakr::get_metadata(input$url) %>%
            buttonmakr::create_button_html()

        template <- readLines("www/template.html")
        data <- list("button" = button)

        writeLines(whisker.render(template, data), "www/output.html")

        includeHTML("www/output.html")

    })
}

# Run the application
shinyApp(ui = ui, server = server)
