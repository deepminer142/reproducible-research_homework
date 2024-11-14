# Step 1: Import the data
data <- read.csv("question-5-data/Cui_etal2014.csv")

# Step 2: View the data to understand its structure
View(data) # Opens a table view to examine the columns and rows

# Step 3: Examine the relationship between genome length and virion volume before log transformation
plot(data$Genome.length..kb., data$Virion.volume..nm.nm.nm.,
     main = "Virion Volume vs Genome Length (Original Scale)",
     xlab = "Genome Length (kb)",
     ylab = "Virion Volume (nm^3)",
     pch = 16, col = "blue")

# Step 4: Log transform the data to linearize the relationship
library(dplyr)
log_transform <- data %>%
  mutate(genome_length_log = log(Genome.length..kb.),
         virion_volume_log = log(Virion.volume..nm.nm.nm.))

# Step 5: Visualize the log-transformed data
plot(log_transform$genome_length_log, log_transform$virion_volume_log,
     main = "Log-Transformed Virion Volume vs Genome Length",
     xlab = "Log of Genome Length (log(kb))",
     ylab = "Log of Virion Volume (log(nm^3))",
     pch = 16, col = "darkgreen")

# Step 6: Create a linear model with the log-transformed data
virus_model <- lm(virion_volume_log ~ genome_length_log, data = log_transform)

# Step 7: View the summary of the model to check coefficients and significance
summary(virus_model)

# Step 8: Add the fitted regression line to the log-transformed scatter plot
abline(virus_model, col = "red", lwd = 2)
  