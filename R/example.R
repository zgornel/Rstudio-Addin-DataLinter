data_path <- "~/projects/DataLinter/test/data/imbalanced_data.csv"
out1 <- read.csv(data_path, header=TRUE)

# LINTER_DATA and LINTER_CODE are used by the DataLinter plugin
LINTER_DATA <- out1
LINTER_CODE <- "m2 <- lm(col4 ~ col1 + col2 + col3, data = out1)"

# HERE we can call the plugin!
# or, run DataLinter::lint()

# Eval and run the code
# eval(LINTER_CODE)
# print(m2)
