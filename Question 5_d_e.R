# For Question 5, part d
# Step 1: Load ggplot2 if not already loaded
install.packages("ggplot2")
library(ggplot2)

# Step 2: Create a linear model with the log-transformed data
virus_model <- lm(virion_volume_log ~ genome_length_log, data = log_transform)

# Step 3: Plot
volume_length_comparison_plot <- ggplot(log_transform, aes(x = genome_length_log, y = virion_volume_log))  + 
  geom_point(color = "black") +                           
  geom_smooth(method = "lm", color = "blue", se = TRUE) + 
  xlab("log [Genome length (kb)]") +                      
  ylab("log [Virion volume (nm3)]") +                    
  theme_bw() +                                            
  theme(text = element_text(size = 14))         

# Step 5: Display plot
print(volume_length_comparison_plot)

# Step 6: Save plot as PNG
ggsave("volume_length_comparison.png", plot = volume_length_comparison_plot, width = 8, height = 6, dpi = 300)

