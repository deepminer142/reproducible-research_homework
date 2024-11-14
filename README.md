# Reproducible research: version control and R

\# INSERT ANSWERS HERE #
## Question 1, 2, 3
https://github.com/deepminer142/logistic_growth/tree/main

## Question 4
### a. 
#### Looking at the code
- random_walk function simulates a two-dimensional random walk in space. 
- random_walk takes n_steps (the number of steps the random walk will take).
- random_walk takes h (here 0.25 units) size steps.
- The root of the walk is (0, 0).
- Therefore, at time = 1, the position is (x = 0, y = 0).
- random_walk moves next step in a random angle.
- Random angle is generated from a uniform distribution between 0 and 2π.
- The new x and y for each step is based on the previous position and the random angle.
- cos(angle) x h = Δx
- sin(angle) x h = Δy

#### Looking at the graph
- All walks start at (0, 0), the root I set.
- Then the walk move at each time step to another vertex.
- In an unweighted random walk, the vertex of the walk is chosen uniformly at random among the neighbours.
- When you re-run the code no two graphs are the same because of the randomness of angle.
- It is a stochastic process.
- The walk's path show clusters then spreading. This pattern may be because short movements in random directions accumulate in certain areas, causing these local clusters.

### b. 
- Random seed is used to initialize a pseudorandom number generator.
- The number sequence completely determined by the seed.
- Therefore, if later initialized with same seed it will produce same number.
- This allows for the graph to be reproducible.
- Setting a random seed allows you to produce the same "random" result every time you rerun the code with the same seed.
- This is essential to produce reprodicble research.

### c. 
### d. 

## Question 5
### a. 
- Rows = 13 (Family, Genus, Type species, GenBank accession no, Envelope, Virion type, T, Virion diameter (nm), Virion length (nm), Virion volume (nm×nm×nm), Molecule, Genome length (kb), Protein no)
- Columns = 33  dsDNA virsues

### b. 
- To testing the allometric relationship between virion volume and genome length I need to transform to log scale (log-log transformation).
- This coverts non-linear relationship into a linear one and so you can fit a linear regression model.

*Coefficients*
| Term              | Estimate | Std. Error | t value | Pr(>|t|) |
|-------------------|----------|------------|---------|----------|
| (Intercept)       | 7.0748   | 0.7693     | 9.196   | 2.28e-10 |
| genome_length_log | 1.5152   | 0.1725     | 8.784   | 6.44e-10 |

![My Image Description](.png)

### c. 
### d.
### e.
