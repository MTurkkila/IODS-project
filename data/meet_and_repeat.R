# # Data wrangling exercise 6 (Analysis of longitudinal data)
# Miikka Turkkila, 27.11.2020

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Load the data sets BPRS and RATS
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Convert the categorical variables of both data sets to factors.
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert the data sets to long form and add temporal variable
BPRSL <-  BPRS %>% 
  gather(key = weeks, value = bprs, -treatment, -subject) %>%
  mutate(week = as.integer(substr(weeks, 5, 5)))

RATSL <- RATS %>%
  gather(key = WD, value = Weight , -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3, 4))) 

# Compare the wide and long form data sets
names(BPRS)
summary(BPRS)
glimpse(BPRS)

names(BPRSL)
summary(BPRSL)
glimpse(BPRSL)

names(RATS)
summary(RATS)
glimpse(RATS)

names(RATSL)
summary(RATSL)
glimpse(RATSL)

# In both original or wide data sets, the temporal aspect of the data is in multiple different variables.
# In the long form the temporality is only on one variable (week or Time) that is basically categorical even tough it is not converted here.
# When gathering the weeks or weekdays into single variable, the data in the original columns are combines into single variable.
# Therefore, the long form data has many more rows but fewer variables.
# The long form data is practical if one want's to compare groups as that combines variable (Here week and Time) can be used  single variable in plots and analyses.

# Save both data set
write.csv(BPRSL, "data/BPRSL.csv", row.names = FALSE)
write.csv(RATSL, "data/RATSL.csv",  row.names = FALSE)

