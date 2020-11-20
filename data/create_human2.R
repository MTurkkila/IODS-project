# Data wrangling exercise 5 (Dimensionality reduction techniques)
# Miikka Turkkila, 20.11.2020

# Access libraries
library(tidyr); library(stringr)

# Load "human" data
human <- read.csv("data/human.csv")

# GNI to numeric
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

# exclude unneeded variables i.e. keeping only wanted variables.
keep <- c("Country", "edu2_ratio", "lab_ratio", "Life_exp", "Year_edu", "GNI", "MMR", "ABR", "Rep")

# select the 'keep' columns
human <- select(human, one_of(keep))

# Removing rows with missing data/values
comp <- complete.cases(human)
human_ <- filter(human, comp == TRUE)

# Remove observations relating to regions (the last 7 rows)
last <- nrow(human_) - 7
human_ <- human_[1:last, ]

# Countries as row names
rownames(human_) <- human_$Country
human_ <- dplyr::select(human_, -Country)

# check that dimension matches to 155, 8
dim(human_)

# Save the data (overwriting the old file)
write.csv(human_, "data/human2.csv")
