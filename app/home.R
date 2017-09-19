# home page

output$pageStub <- renderUI(
   fluidRow(
      column(5,
         HTML("<p>This is the home page of our excellent web site.</p>",
              "<p>There's a second page that displays data about Old Faithful.",
              "On that page you can move the slider to increase or decrease the",
              "number of bins in the histogram.</p>",
              "<p>The third link goes to a page that doesn't exist to demonstrate",
              "error handling for bad URLs.</p>")
      )
   )
)
