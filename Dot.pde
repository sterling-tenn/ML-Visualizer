class Dot
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  Brain brain; // Declare brain object from Brain file
  
  boolean is_dead = false; // Keep track if the dot is alive or dead
  boolean goal_reached = false; // Keep track if the dot has reached the goal
  
  float fitness = 0; // Declare a fitness variable to quantify how good of a dot it is
  
  boolean is_best_dot = false; // Keep track if this dot is a good dot of its generation
  
  Dot() // Constructor
  {
    position = new PVector(300,height-25); // Initialize position
    velocity = new PVector(0,0); // Initiate to 0 (x and y)
    acceleration = new PVector(0,0); // Initiate to 0 (x and y)
    
    brain = new Brain(300); // Initialize the brain to have 300 directions
  }
  
  void show()
  {
    if(is_best_dot == true) // Colour the best dot differently to differentiate it
    {
      fill(255,0,0);
      ellipse(position.x,position.y,15,15);
    }
    else
    {
      fill(102,178,255); // All subsequent shapes will be this RGB colour (blue)
      ellipse(position.x,position.y,5,5); // Create circle with width and height 3 at the dot's x and y position
    }
  }
  
  void move()
  {
    
   // We want to change the dot's acceleration the same number of times as the number of directions the brain has
   if(brain.directions.length > brain.counter)
   {
    acceleration = brain.directions[brain.counter]; // Set acceleration to the next direction
    brain.counter++; // Next direction
   }
   else // The dot has run out of directions to follow
   {
     is_dead = true; // Kill the dot
   }
    
   velocity.add(acceleration);  // Add the current acceleration to the velocity
   velocity.limit(10); // Limit the velocity of the dot or else the dot will just keep adding accelerations
   position.add(velocity); // Add the current velocity to the position - do this after adding acceleration to velocity since position is dependent on velocity
  }
  
  void update() // Update the dot
  {
    if(is_dead == false && goal_reached == false) // Only update and move the dot if it's alive, and if the goal has not been reached
    {
      move(); // Move the dot
      
      if(position.x <= 0 || position.y <= 0 || position.x >= width || position.y >= height) // If the dot is out of bounds of the window
      {
        is_dead = true; // Kill the dot
      }
      else if(dist(position.x,position.y,goal.x,goal.y) < 3) // If the position of the dot is close enough to the goal's position
      {
        goal_reached = true;
      }
      else // Check for collisions with anything else
      {
        for(int i=0;i<obstacles.length;i++) // Check collisions with all obstacles
        {
          if(position.x >= obstacles[i].xpos && position.y >= obstacles[i].ypos && position.x <= obstacles[i].xpos+obstacles[i].w && position.y <= obstacles[i].ypos+obstacles[i].h)
          {
            is_dead = true; // Kill the dot if it hits an obstacle
          }
        }
      }
    }
  }
  
  void calculate_fitness() // A way to quantify how well a dot did
  {
    if(goal_reached == true)
    {
      fitness = 1.0 + 1/(float)(brain.counter * brain.counter); // Encourage the dot to take less steps, give extra fitness so reaching the goal has a better score
    }
    else
    {
      
      float distance_to_goal = dist(position.x,position.y,goal.x,goal.y); // Calculate the distance to the goal
      fitness = 1/(distance_to_goal * distance_to_goal); // Inverse since smaller distance means better fitness score; square score so smaller changes in distance result in a much better fitness score
      
    }
  }
  
  Dot get_child()
  {
   Dot child = new Dot(); // Create a child dot
   child.brain = brain.clone(); // Clone the brain of the parent to its child
   // Maybe add crossover with another parent later for better genes
   return child;
  }
  
}
