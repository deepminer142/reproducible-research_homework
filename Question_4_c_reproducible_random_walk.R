# Step 1: Load the necessary libraries
library(ggplot2) 

# Step 2: Set the seed for reproducibility
# Setting a random seed ensures that the random values generated will be the same every time you run the code.
# This allows consistent results and helps in testing and verifying the analysis.
set.seed(626)

# Step 3: Generate the first random walk data
# Call `random_walk(500)` to create a dataset with 500 steps
data1 <- random_walk(500)

# Step 4: Create the first plot using ggplot2
plot1 <- ggplot(aes(x = x, y = y), data = data1) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")

# Step 5: Generate the second random walk data
data2 <- random_walk(500)

# Step 6: Generate the second random walk data
plot2 <- ggplot(aes(x = x, y = y), data = data2) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")

# Step  7: Arrange two plots side by side
grid.arrange(plot1, plot2, ncol=2)



