# Miikka Turkkila 31.10.2020
# IODS2020 Exercise 2: regression and model validation

# Access the dplyr library
library(dplyr)

# Read the data from web
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Dimensions and structure
dim(learning2014)
str(learning2014)
# Output shows that the data consists of 60 variables and 183 observations.
# There is variables for age, attitude, points, gender and, I guess, questionnaire items
# All variables, expect gender, have integer values. Gender is factorized.

# Deep, stra and surf questions from datacamp exercise
deep <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
stra <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surf <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

# combine data, calculate mean and add to the table
learning2014$deep <- rowMeans(select(learning2014, one_of(deep)))
learning2014$stra <- rowMeans(select(learning2014, one_of(stra)))
learning2014$surf <- rowMeans(select(learning2014, one_of(surf)))


# Select analysis dataset from learning2014
students2014 <- filter(select(learning2014, one_of(c("gender","Age","Attitude", "deep", "stra", "surf", "Points"))), Points > 0)

# Write students2014 as a table to the data folder
write.table(students2014, "data/students2014.txt", sep="\t")

# Read the table and check structure
data <- read.table("data/students2014.txt", sep="\t")
str(data)
head(data)
# ALL GOOD!