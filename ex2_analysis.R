# Miikka Turkkila 31.10.2020
# IODS2020 Exercise 2: regression and model validation, Analysis

# access the ggplot2 and GGally libraries
library(ggplot2)
library(GGally)

# Read the data
students2014 <- read.table("data/students2014.txt", sep="\t")
str(students2014)
dim(students2014)
# Data has 7 variables and 166 observations from questionnaire.
# deep, stra and surf are sum variables scaled to original scale.
# Data only includes observations with point over 0

# create plot matrix with ggpairs() and draw the plot
p <- ggpairs(students2014, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))
p

# Save the plot
dev.copy(jpeg,filename="plots/ex2_overview.jpg")
dev.off ()

# show summaries 
summary(students2014)

# Attitude, stra and surf have the highest absolute correlation with points
# Let's choose those for the initial linear model
# create a regression model with multiple explanatory variables
my_model <- lm(Points ~ Attitude + stra + surf, data = students2014)
# show summary of the model
summary(my_model)

# Only attitude is statistically significant
my_model2 <- lm(Points ~ Attitude, data = students2014)
summary(my_model2)

# draw diagnostic plot
par(mfrow = c(2,2))
plot(my_model2, which = c(1, 2, 5))

# Let's also save this plot
dev.copy(jpeg,filename="plots/ex2_diagnostic.jpg")
dev.off ()