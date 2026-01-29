library(shiny)
library(miniUI)
library('httr')
library('rjson')
library('tuple')

datalinter <- function() {
ui <- fluidPage(
  "Hello, world!"
)
server <- function(input, output, session) {

### DATAPATH <- args[1]
### CODEPATH <- args[2]
### #df <- read.csv(DATAPATH, header = TRUE, sep = ",")
### datastring <-paste(readLines(DATAPATH), collapse="\n")
### codestring <-paste(readLines(CODEPATH), collapse="\n")
### 
### linter_input <- list(linter_input=list(
###                                        context = list(
###                                                     data=datastring,
###                                                     data_delim=",",
###                                                     data_header=TRUE,
###                                                     code=codestring),
###                                         options = list(
###                                                     show_stats=TRUE,
###                                                     show_passing=FALSE,
###                                                     show_na=FALSE)
###                                         )
###                     )
### 
### json_input = rjson::toJSON(linter_input)
### r = httr::POST(url="http://0.0.0.0:10000/api/lint", body=json_input, encode="raw")
### content = content(r, as="text")
### output = rjson::fromJSON(content)
### cat(output$linting_output)

}
shinyApp(ui, server)
}


# Try running the clock!
datalinter()
