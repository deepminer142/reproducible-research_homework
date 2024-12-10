# Load Libraries
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(gridExtra)
  library(TidyDensity)
})

# Set a Seed for Reproducibility
set.seed(123)

# Random Walk Function with X, Y Coordinates and Time Gradient
random_walk <- function(n_steps) {
  df <- data.frame(x = rep(NA, n_steps), y = rep(NA, n_steps), time = 1:n_steps)
  df[1, ] <- c(0, 0, 1)
  
  for (i in 2:n_steps) {
    h <- 0.25
    angle <- runif(1, min = 0, max = 2 * pi)
    df[i, 1] <- df[i - 1, 1] + cos(angle) * h
    df[i, 2] <- df[i - 1, 2] + sin(angle) * h
    df[i, 3] <- i
  }
  
  return(df)
}

# Generate Data for Different Distributions
df <- bind_rows(
  tidy_uniform(.num_sims = 1, .n = 500, .min = -1, .max = 1) %>%
    mutate(
      angle = runif(n(), min = 0, max = 2 * pi),
      step_size = 0.25,
      x = cumsum(cos(angle) * step_size),
      y = cumsum(sin(angle) * step_size),
      time = row_number(),
      type = "Uniform"
    ),
  
  tidy_exponential(.num_sims = 1, .n = 500, .rate = 1) %>%
    mutate(
      angle = runif(n(), min = 0, max = 2 * pi),
      step_size = 0.25,
      x = cumsum(cos(angle) * step_size),
      y = cumsum(sin(angle) * step_size),
      time = row_number(),
      type = "Exponential"
    ),
  
  tidy_normal(.num_sims = 1, .n = 500, .mean = 0, .sd = 1) %>%
    mutate(
      angle = runif(n(), min = 0, max = 2 * pi),
      step_size = 0.25,
      x = cumsum(cos(angle) * step_size),
      y = cumsum(sin(angle) * step_size),
      time = row_number(),
      type = "Normal"
    )
)

# Create Plots for Each Distribution
plots <- df %>%
  split(.$type) %>%
  purrr::map(~ {
    ggplot(.x, aes(x = x, y = y, color = time)) +
      geom_path() +
      labs(
        title = paste("Random Walk:", unique(.x$type)),
        x = "X-Coordinate",
        y = "Y-Coordinate"
      ) +
      theme_bw() +
      scale_color_gradient(low = "lightblue", high = "darkblue")
  })

# Arrange and Save the Combined Plot
combined_plot <- grid.arrange(grobs = plots, ncol = 3)
ggsave("random_walk_comparison_combined.png", plot = combined_plot, width = 15, height = 6, dpi = 300)
