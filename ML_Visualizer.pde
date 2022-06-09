Population population;
PVector goal = new PVector (300,50);

Obstacle[] obstacles = new Obstacle[5];

void setup()
{
 size(600,600); 
 frameRate(1000);
 population = new Population(750);

}

void draw() // Is called every frame
{
  background(255,255,255); // Clear screen so dots don't stay
   
  fill(0,255,0); // Colour of the goal
  ellipse(goal.x,goal.y,10,10); // Draw the goal
  
  // Horizontal obstacles
  obstacles[0] = new Obstacle(0,400,200,10);
  obstacles[1] = new Obstacle(400,400,200,10);
  obstacles[2] = new Obstacle(175,300,250,10);
  obstacles[3] = new Obstacle(0,200,200,10);
  obstacles[4] = new Obstacle(400,200,200,10);

  
  if(population.is_population_dead() == true) // Check is the population is dead
  {
    population.calculate_fitness();
    //population.show();
    
    population.natural_selection();
    population.mutate_children();
  }
  else
  {
    population.update(); // Update the dots
    population.show(); // Then show the dots
  }
  
}
