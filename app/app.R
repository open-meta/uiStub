### uiStub
### v1.2 - Tom Weishaar - Sep 2017

### v1.1 fixes a security issue
###    for details, see: https://groups.google.com/forum/?utm_source=digest&utm_medium=email#!topic/shiny-discuss/zxoLK1kKTCw)
### v1.2 adds some tagList() functions that aren't strictly required here, but make it
###    much easier to expand this code.

### Simple demo program that "moves" the ui into the server, thereby allowing the use of
###    the URL "search" protocol to create multi-page web sites. The advantage is that
###    each page can have its own file (to keep things organized) and only one file is
###    loaded into Shiny Server at a time, limiting memory usage.

### Note, the URL "path" protocol currently doesn't work, because Shiny Server currently
###    returns a "not found" error rather than passing the path to the session.

library(shiny)

ui <- uiOutput("uiStub")                                # single-output stub ui

print("uiStub application loaded...")                   # note this prints only once... (in
                                                        #    console locally or in server log)
server <- function(input, output, session) {

   # build menu; same on all pages
   output$uiStub <- renderUI(tagList(                   # a single-output stub ui basically lets you
      fluidPage(                                        #     move the ui into the server function
         fluidRow(
            column(12,
               HTML("<h3><a href='?home'>Home</a> | ",
                    "<a href='?oldFaithful'>Old Faithful</a> |",
                    "<a href='?page3'>Nothing</a>",
                    "</h3>")
               )
            ),
         uiOutput("pageStub")                              # loaded server code should render the
      )
   ))                                                   #    rest of the page to this output$

   # load server code for page specified in URL
   validFiles = c("home.R", "oldFaithful.R")            # valid files must be hardcoded here
                                                        #    for security
   fname = isolate(session$clientData$url_search)       # isolate() deals with reactive context

   print(paste0("New session, filename: ", fname))      # note this prints for each new URL...
                                                        #    (a new URL gets a new server() function)
   if(nchar(fname)==0) { fname = "?home" }              # blank means home page
   fname = paste0(substr(fname, 2, nchar(fname)), ".R") # remove leading "?", add ".R"
   if(!fname %in% validFiles){                          # is that one of our files?
      output$pageStub <- renderUI(tagList(              # 404 if no file with that name
         fluidRow(
            column(5,
               HTML("<h2>404 Not Found Error:</h2><p>That URL doesn't exist. Use the",
                    "menu above to navigate to the page you were looking for.</p>")
            )
         )
      ))
      return()                                          # prevents a "file not found" error on
   }                                                    #    the next line after a 404 error
   source(fname, local=TRUE)                            # load and run server code for this page
}
# Run the application
shinyApp(ui = ui, server = server)
