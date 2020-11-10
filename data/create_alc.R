# Miikka Turkkila, 10.10.2020
# Data wrangling exercise for logistic regression, joiningdata together

# access the dplyr library
library(dplyr)

# read in the two data files and check dimension and structure
student_mat <- read.csv("data/student-mat.csv", header = TRUE, sep = ";")
dim(student_mat)
str(student_mat)

studedent_por <- read.csv("data/student-por.csv", header = TRUE, sep = ";")
dim(studedent_por)
str(studedent_por)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
mat_por <- inner_join(student_mat, studedent_por, by = join_by, suffix = c(".math", ".por"))
dim(mat_por)
str(mat_por)

# mat_por now includes duplicate observations, use datacamp else-if structure to fix it
# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# now dimensions matches original data
dim(alc)


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse the modified data to check everything is as instructed and it is.
glimpse(alc)

# Save the data
write.csv(alc, file = "data/alc.csv")
