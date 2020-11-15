# Miikka Turkkila 15.11.2020
# Data wrangling ex4

library(dplyr);

# Read the datasets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Structure, dimensions and summary

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# change column names
hd <- setNames(hd, c("HDI_rank", "Country", "HDI", "Life_exp", "Year_edu", "Mean_edu", "GNI", "GNI_rank-HDI_rank"))

gii <- setNames(gii, c("GII_rank", "Country", "GII", "MMR", "ABR", "Rep", "edu2F", "edu2M", "labF", "labM"))

# Mutate "GEnder inequality" data
gii <- mutate(gii, edu2_ratio = edu2F / edu2M)
gii <- mutate(gii, lab_ratio = labF / labM)

# Join the data
human <- inner_join(hd, gii, by = "Country")
dim(human) # check dim, matches

# Save
write.csv(human, file = "data/human.csv", row.names = FALSE)