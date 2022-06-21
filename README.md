# Genetic Algorithm Visualizer

This program utilizes the [NEAT (NeuroEvolution of Augmenting Topologies)](https://en.wikipedia.org/wiki/Neuroevolution_of_augmenting_topologies) genetic algorithm to simulate a population evolving through generations to reach a goal.
# Timelapse
![](https://github.com/sterling-tenn/ML-Visualizer/blob/main/imgs/timelapse.gif?raw=true)
The dot at the top is the goal the population is attempting to reach and the best performing dot of each generation is shown as a bigger red dot.
# The Process
Here's the algorithm explained in a generic sense:
 1. Start with a population (i.e. the first generation) which is completely random and chaotic. In this visualizer, each dot is initialized with a set of arbitrary direction vectors that dictate their movement.
 2. Let the population move around until the entire generation is dead
 3. Calculate the fitness of each member of the generation
	*	In this example, fitness is calculated from the distance each dot made it to the goal before dying. (Closer to the goal = Higher fitness score)
 4. Create a new generation based on the previous generation
	 *	A member of the previous generation with a higher fitness score should have a higher **probability** of having a child in the next generation that inherits it's superior genes
		 *	In this visualizer I copied the genes of a single selected parent directly to the child, but for better results, selecting two parents and splicing their genes together to create a child would help diversify the gene pool.
	 *	Keep the best member(s) of the previous generation in the next generation - manually insert/copy it to the next generation **without** mutating it, as mentioned in step 5
		 *	This is to prevent the new generation as a whole from possibly becoming worse if it happens that the best performing member of the new generation mutates negatively.
 5. Now that we have created a new generation, we want each member of it to have a *chance* of having a *random* mutation occur to it (Good or bad). This is to increase the variety in the gene pool to *hopefully* eventually get better members each generation to get solutions that could not have been derived from the original population.
 6. Rinse and repeat!
