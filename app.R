library(shiny)
library(shinyWidgets)
library(qrcode)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("cosmo"),
  titlePanel("QR Code Generator"),
  sidebarLayout(
    sidebarPanel(
      textAreaInput(inputId = "text", 
                    label = "Text to be converted", 
                    value = "https://www.google.com",
                    placeholder = "Enter your text here..."),
      hr(),
      textInput(inputId = "bgcolor",
                label = "Background Color",
                value = "white"),
      textInput(inputId = "ftcolor",
                label = "Front Color",
                value = "black"),
      actionBttn("generate", 
                 "Generate QR Code", 
                 block = TRUE,
                 style = "fill"),
      br(),
      hr(),
      tags$footer(p("This App is developed by Wanjun Gu under MIT license.")),
      a("Github Repo: Broccolito", href = "https://github.com/Broccolito?tab=repositories")
    ),
    mainPanel(plotOutput("qrcode", width = "100%", height = "400px"))
  )
)

server <- function(input, output, session) {

  output$qrcode = renderPlot({
    
    input$generate
    
    p = isolate(qrcode_gen(input$text, dataOutput = TRUE))
    bgcolor = isolate(input$bgcolor)
    ftcolor = isolate(input$ftcolor)
    
    return(
      heatmap(p[nrow(p):1, ], Rowv = NA,
              Colv = NA, scale = "none", col = c(bgcolor, ftcolor),
              labRow = "", labCol = "")
    )
    
  })

}

shinyApp(ui, server)