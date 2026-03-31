lint <- function() {
  data_varname <- "LINTER_DATA"

  # Extract LINTER_CODE using RStudioAPI: mouse selection (if any) or current cursor line
  context <- rstudioapi::getActiveDocumentContext()
  if (is.null(context)) {
    return(message("No active RStudio document context available."))
  }

  sel <- context$selection[[1]]
  if (nchar(trimws(sel$text)) > 0) {
    codestring <- sel$text
  } else {
    # Fall back to the line where the cursor is positioned
    line_num <- sel$range$start[1]
    if (line_num < 1 || line_num > length(context$contents)) {
      codestring <- ""
    } else {
      codestring <- context$contents[[line_num]]
    }
  }

  if (nchar(trimws(codestring)) == 0) {
    return(message("No code in mouse selection or on the current cursor line."))
  }

  # Helper to recursively find the first 'data=' argument expression in any call
  find_data_expr <- function(e) {
    if (!is.call(e)) {
      return(NULL)
    }
    # Check for named 'data' argument
    arg_names <- names(as.list(e))
    if ("data" %in% arg_names) {
      data_idx <- which(arg_names == "data")
      return(as.list(e)[[data_idx]])
    }
    # Recurse into all sub-expressions (arguments)
    for (i in seq_along(e)[-1]) {
      res <- find_data_expr(e[[i]])
      if (!is.null(res)) {
        return(res)
      }
    }
    return(NULL)
  }

  # Try to extract data= from the selected code (first occurrence wins)
  data_expr <- NULL
  tryCatch({
    parsed_exprs <- parse(text = codestring, keep.source = FALSE)
    for (ex in as.list(parsed_exprs)) {
      res <- find_data_expr(ex)
      if (!is.null(res)) {
        data_expr <- res
        break
      }
    }
  }, error = function(e) {
    # Invalid / incomplete R code in selection -> silently fall back to global env
    NULL
  })

  # Resolve LINTER_DATA: prefer data= field from code, otherwise fall back to global env (as original)
  df <- NULL
  if (!is.null(data_expr)) {
    df <- tryCatch(
      eval(data_expr, envir = .GlobalEnv),
      error = function(e) {
        # Could not evaluate the data= expression (e.g. object not found)
        NULL
      }
    )
  }

  if (is.null(df)) {
    if (exists(data_varname, envir = .GlobalEnv)) {
      df <- get(data_varname, envir = .GlobalEnv)
    } else {
      return(message(paste0("No 'data=' field found in the selected code ",
                            "and no variable named '", data_varname, "' ",
                            "available in the global environment.")))
    }
  }

  # Prepare data as CSV string
  datastring <- paste(capture.output(write.csv(df, "", row.names = FALSE)),
                      collapse = "\n")

  # Build payload
  linter_input <- list(linter_input = list(
    context = list(
      data = datastring,
      data_delim = ",",
      data_header = TRUE,
      data_type = "dataset",
      code = codestring
    ),
    options = list(
      show_stats = TRUE,
      show_passing = FALSE,
      show_na = FALSE
    )
  ))

  json_input <- rjson::toJSON(linter_input)
  r <- httr::POST(url = "http://0.0.0.0:10000/api/lint",
                  body = json_input,
                  encode = "raw")
  content <- httr::content(r, as = "text")
  output <- rjson::fromJSON(content)
  message(output$linting_output)
}
