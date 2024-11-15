# Step 1: Load libraries
library(ggplot2)
library(dplyr)
library(TidyDensity)

# Step 2: Set Seed
set.seed(623)

# Step 3: Generate random walks with different distributions
df <- rbind(
  tidy_uniform(.num_sims = 25, .n = 50, .min = -1, .max = 1) |>
    tidy_random_walk(.value_type = "cum_sum") |>
    mutate(type = "Uniform"),
  
  tidy_exponential(.num_sims = 25, .n = 50, .rate = 1) |>
    tidy_random_walk(.value_type = "cum_sum") |>
    mutate(type = "Exponential"),
  
  tidy_normal(.num_sims = 25, .n = 50, .mean = 0, .sd = 1) |>
    tidy_random_walk(.value_type = "cum_sum") |>
    mutate(type = "Normal")
) |>
  select(sim_number, x, random_walk_value, type) |>
  mutate(
    low_ci = -1.96 * sqrt(x),
    hi_ci = 1.96 * sqrt(x)
  )

# Step 4: Extract attributes for the plot subtitle
atb <- attributes(df)

# Step 5: Plot 
plot <- df |>
  ggplot(aes(
    x = x, 
    y = random_walk_value, 
    group = sim_number, 
    color = factor(type))
  ) +
  geom_line(aes(alpha = 0.382)) +
  geom_line(aes(y = low_ci, group = sim_number), 
            linetype = "dashed", linewidth = 0.6, color = "black") +
  geom_line(aes(y = hi_ci, group = sim_number), 
            linetype = "dashed", linewidth = 0.6, color = "black") +
  scale_color_manual(values = c("Uniform" = "blue", 
                                "Exponential" = "green", 
                                "Normal" = "purple")) +
  theme_minimal() +
  theme(legend.position = "none") +
  facet_wrap(~type) +
  labs(
    x = "Time",
    y = "Value",
    title = "Random Walk using Different Distributions"
  )

# Step 6: Save the plot to a PNG file
ggsave("random_walk_distributions.png", plot = plot, width = 10, height = 6, dpi = 300)
