# Step 1: Load Libraries
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(TidyDensity)
})

# Step 2: Set a Seed for Reproducibility
set.seed(1000)

# Step 3: Generate Random Walks for Different Distributions
df <- bind_rows(
  tidy_uniform(.num_sims = 25, .n = 50, .min = -1, .max = 1) %>%
    tidy_random_walk(.value_type = "cum_sum") %>%
    mutate(type = "Uniform"),
  
  tidy_exponential(.num_sims = 25, .n = 50, .rate = 1) %>%
    tidy_random_walk(.value_type = "cum_sum") %>%
    mutate(type = "Exponential"),
  
  tidy_normal(.num_sims = 25, .n = 50, .mean = 0, .sd = 1) %>%
    tidy_random_walk(.value_type = "cum_sum") %>%
    mutate(type = "Normal")
) %>%
  select(simulation = sim_number, step = x, value = random_walk_value, type)

# Step 4: Create the Plot Object
plot <- ggplot(df, aes(x = step, y = value, color = type, group = interaction(type, simulation))) +
  geom_line(alpha = 0.4) +
  scale_color_manual(values = c("Uniform" = "#1f78b4", "Exponential" = "#33a02c", "Normal" = "#6a3d9a")) +
  facet_wrap(~ type) +
  labs(
    title = "Random Walks with Different Distributions",
    x = "Time Step",
    y = "Random Walk Value"
  ) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")

# Step 5: Save the Plot as a PNG File
ggsave(filename = "random_walk_different_distributions.png", plot = plot, width = 10, height = 6, dpi = 300)
