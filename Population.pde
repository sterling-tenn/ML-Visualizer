// We want a bunch of dots now
class Population
{
  Dot[] dots; // Declare an array "dots" of type "Dot"

  float total_fitness; // Declare a variable to keep track of the population's total fitness - used to select the parent

  int generation = 1; // Keep track of the current generation of the population

  int best_dot_index; // Keep track of the best dot in the population to keep in the next generation - stop negative mutations on the best dot

  int minimum_steps_taken = 9999; // Keep track of the minimum amount of steps the best dot took - limit subsequent dots to at least this amount

  Population(int size) // Constructor
  {
    dots = new Dot[size]; // Initialize the array "dots" to specified size
    for (int i=0; i<size; i++) // For the size of the array
    {
      dots[i] = new Dot(); // Initialize every dot in the array to a new Dot
    }
  }

  void show() // Show all the dots in the population
  {
    for (int i=0; i<dots.length; i++) // For every dot in the array
    {
      dots[i].show(); // Call the show() function of the Dot class for each dot
    }
  }

  void update() // Update all the dots in the population
  {
    for (int i=0; i<dots.length; i++) // For every dot in the array
    {
      if (dots[i].brain.counter > minimum_steps_taken) // If the dot took more steps than it did previously
      {
        dots[i].is_dead = true; // Kill the dot
      } else
      {
        dots[i].update(); // Call the update() function of the Dot class for each dot
      }
    }
    surface.setTitle("Generation: " + str(generation) + "     Minimum Steps: " + str(minimum_steps_taken));
  }

  void calculate_fitness() // Update all of the dots' fiteness score
  {
    for (int i=0; i<dots.length; i++) // For every dot in the array
    {
      dots[i].calculate_fitness(); // Call the calculate_fitness() function of the Dot class for each dot
    }
  }

  boolean is_population_dead() // To check if all the dots in the population are dead - to indicate whether or not to start the next generation
  {
    for (int i=0; i<dots.length; i++) // For every dot in the array
    {
      if (dots[i].is_dead == false && dots[i].goal_reached == false) // If the dot is still alive, and the dot has not reached the goal
      {
        return false; // Return false
      }
    }
    return true;
  }

  void natural_selection() // Get the next generation of dots
  {
    Dot[] next_generation_dots = new Dot[dots.length]; // Create new array of dots the same length as the old array for the next generation of dots

    calculate_total_fitness();

    set_best_dot(); // Get the indexes of the good dots of the generation

    next_generation_dots[0] = dots[best_dot_index].get_child(); // Manually insert the best dot of the previous generation into the next generation
    next_generation_dots[0].is_best_dot = true;

    for (int i=1; i<dots.length; i++) // Start at 1 because the best dot was inserted at the beginning of the array
    {
      Dot parent = select_parent(); // Select the parent dot to get its child from
      next_generation_dots[i] = parent.get_child(); // Add the child to the next generation of dots
    }

    dots = next_generation_dots; // Set the current population to the next generation

    generation++; // Increment the generation counter
  }

  Dot select_parent() // Parent dot with a higher fitness has a higher chance of being selected for it's genes to be passed to the next generation (it's child)
  {

    float threshold = random(total_fitness); // Dots with a higher fitness score have a higher chance of having the threshold select it
    float current_fitness = 0;

    for (int i=0; i<dots.length; i++)
    {
      current_fitness += dots[i].fitness;
      if (current_fitness > threshold)
      {
        return dots[i];
      }
    }
    return null;
  }

  void calculate_total_fitness() // Calculate the total fitness of the population
  {
    total_fitness = 0;
    for (int i=0; i<dots.length; i++)
    {
      total_fitness += dots[i].fitness;
    }
  }

  void mutate_children() // Mutate the children/next generation
  {
    for (int i=1; i<dots.length; i++) // For every dot in the array - except the first dot since it's the best dot of the previous generation
    {
      dots[i].brain.mutate(); // Directly mutate the brain of the children
    }
  }

  void set_best_dot() // Find the indexes of the best dots of the generation (highest fitness)
  {
    float best_fitness = 0;
    for (int i=0; i<dots.length; i++)
    {
      if (dots[i].fitness > best_fitness)
      {
        best_fitness = dots[i].fitness;
        best_dot_index = i;
      }
    }

    if(dots[best_dot_index].goal_reached)
    {
      minimum_steps_taken = dots[best_dot_index].brain.counter;
      //println("Mimumum steps:",minimum_steps_taken);
    }

  }
}
