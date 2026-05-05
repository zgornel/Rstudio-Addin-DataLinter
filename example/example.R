library(glmmTMB)
data_path <- "~/projects/DataLinter/test/data/imbalanced_data.csv"
#data_path <- "~/projects/DataLinter/test/data/correlated_target_data.csv"
#data_path <- "~/projects/DataLinter/test/data/correlated_data.csv"
out1 <- read.csv(data_path, header=TRUE)
m2 <- glmmTMB(col4 ~ col1 + col2 + col3,
              data = out1,
              family=binomial(link=linear))
print(m2)
m3 <- glm(col4~col1+col2, data=out1, family="binomial")
print(m3)
