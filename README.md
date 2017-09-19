# uiStub
Demonstration of how to create a URL-based, multi-page Shiny web site.

This is a simple demo program that "moves" the ui into the server, thereby allowing the use of the URL "search" protocol to create multi-page web sites. The advantage is that each page can have its own file (to keep things organized) and only one file is loaded into Shiny Server at a time, limiting memory usage.

Note, the URL "path" protocol currently doesn't work, because Shiny Server currently returns a "not found" error on any path other than "/", rather than passing the path to the session. This issue has been reported.

You can see the program run at https://open-meta.shinyapps.io/uistub/
