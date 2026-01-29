library(shiny)
library(miniUI)
library(httr)
library(rjson)
library(tuple)

lint <- function() {
    #datastring <-paste(readLines(datapath), collapse="\n")
    #codestring <-paste(readLines(codepath), collapse="\n")
    code_varname = "LINTER_CODE"
    data_varname = "LINTER_DATA"
    if (!exists(data_varname, envir = .GlobalEnv))
        return(message("code", paste("No variable named '", data_varname, "' available.")))
    if (!exists(code_varname, envir = .GlobalEnv))
        return(message("code", paste("No variable named '", code_varname, "' available.")))

    codestring <- get("LINTER_CODE", envir=.GlobalEnv)
    df <- get("LINTER_DATA", envir=.GlobalEnv)
    datastring <- paste(capture.output(write.csv(out1,"", row.names = FALSE)), collapse="\n")
    linter_input <- list(linter_input=list(
                                           context = list(
                                                        data=datastring,
                                                        data_delim=",",
                                                        data_header=TRUE,
                                                        code=codestring),
                                            options = list(
                                                        show_stats=TRUE,
                                                        show_passing=FALSE,
                                                        show_na=FALSE)
                                            )
                        )

    json_input = rjson::toJSON(linter_input)
    r = httr::POST(url="http://0.0.0.0:10000/api/lint", body=json_input, encode="raw")
    content = content(r, as="text")
    output = rjson::fromJSON(content)
    message(output$linting_output)

}


lint()
