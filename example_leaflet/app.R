#
# This shiny web application demonstrates the use of custom icons in leaflet
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # include the css file - necessary for styling the second custom icon
    includeCSS(file.path("www", "custom_icon.css")),

    # Application title
    titlePanel("Bavarian breweries"),

    # the geographic map
    leafletOutput("map")
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$map <- renderLeaflet({
      map <- leaflet(cbind(breweries91@data, breweries91@coords)) %>%
        # Add the base map
        addTiles(group = "OSM (default)") %>%
        # Add markers on the position of the breweries
        addMarkers(~longitude, ~latitude, popup=~brewery) %>%
        # Add a custom button with a standard icon that shows the whole world
        addEasyButton(
          easyButton(
            icon = "fa-globe",
            title = "world",
            onClick = JS("function(btn, map){map.flyTo([0, 0], 1);}")
          )
        ) %>%
        # Add a custom button with a custom icon that zooms in to the breweries
        addEasyButton(
          easyButton(
            icon = icon(name=NULL, class="custom_icon"),
            title = "home",
            onClick = JS("function(btn, map){map.flyToBounds([[49, 10], [50, 11]])}")
          )
        )

      map
    })
}

# Run the application
shinyApp(ui = ui, server = server)
