#
# This shiny web application demonstrates the use of custom icons
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # include the css file - necessary for styling the second custom icon
    includeCSS(file.path("www", "custom_icon.css")),

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a button inputs for number of bins
    sidebarLayout(
        sidebarPanel(

          # actionbutton with an icon from the standard Font Awesome library
          actionButton(
            inputId = "home",
            label = "",
            icon = icon("house")
          ),

          # actionButton with a custom icon specified in this R-script
          actionButton(
            inputId = "few",
            label = "",
            icon = icon(
              name = NULL,
              style = "
                background: url('custom_icon_1.svg');
                background-size: contain;
                background-position: center;
                background-repeat: no-repeat;
                height: 32px;
                width: 32px;
                display: block;
              "
            )
          ),

          # actionButton with a custom icon specified in a separate css-file
          actionButton(
            inputId = "many",
            label = "",
            icon = icon(
              name = NULL,
              class = "custom_icon"
            )
          )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    # initiate the number of bins
    number.of.bins = reactiveVal(30)

    # observe the presses of the actionButtons
    observeEvent(input$home, number.of.bins(30))
    observeEvent(input$few, number.of.bins(10))
    observeEvent(input$many, number.of.bins(60))

    output$distPlot <- renderPlot({
        # generate bins based on the number.of.bins reactive value
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = number.of.bins())

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application
shinyApp(ui = ui, server = server)
