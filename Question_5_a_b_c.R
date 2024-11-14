# Step 1: Load necessary libraries
install.packages("ggplot2")
install.packages("dplyr")
library(ggplot2)
library(dplyr)

# Step 2: Import the data
data <- read.csv("question-5-data/Cui_etal2014.csv")

# Step 3: Plot relationship between genome length and virion volume 
plot_original <- ggplot(data, aes(x = Genome.length..kb., y = Virion.volume..nm.nm.nm.)) +
  geom_point(color = "blue") +
  labs(title = "Virion Volume vs Genome Length (Original Scale)",
       x = "Genome Length (kb)",
       y = "Virion Volume (nm^3)")

print(plot_original)
ggsave("virion_volume_vs_genome_length.png", plot = plot_original, width = 8, height = 6)

# Step 4: Log transform the data
log_transform <- data %>%
  mutate(genome_length_log = log(Genome.length..kb.),
         virion_volume_log = log(Virion.volume..nm.nm.nm.))

# Step 5: Visualize the log-transformed data
plot_log_transformed <- ggplot(log_transform, aes(x = genome_length_log, y = virion_volume_log)) +
  geom_point(color = "blue") +
  labs(title = "Log-Transformed Virion Volume vs Genome Length",
       x = "Log of Genome Length (log(kb))",
       y = "Log of Virion Volume (log(nm^3))")

print(plot_log_transformed)
ggsave("log_transformed_virion_volume_vs_genome_length.png", plot = plot_log_transformed, width = 8, height = 6)

# Step 6: Create linear model 
virus_model <- lm(virion_volume_log ~ genome_length_log, data = log_transform)

# Step 7: View the summary of the model to check coefficients and significance
summary(virus_model)

# Step 8: Plot model with fitted regression line
plot_with_regression <- plot_log_transformed +
  geom_smooth(method = "lm", color = "blue") +
  labs(title = "Log-Transformed Virion Volume vs Genome Length with Regression Line")

print(plot_with_regression)
ggsave("log_transformed_virion_volume_vs_genome_length_with_regression.png", plot = plot_with_regression, width = 8, height = 6)

