// Each dot will have a brain
class Brain
{
  PVector[] directions; // Declare an array "directions" of PVectors - will be used to set the dot's INITIAL acceleration(s)
  int counter = 0; // To keep track of the number of directions the dot has to follow
  
  Brain (int size)
  {
    directions = new PVector[size]; // Initialize the array "directions" to specified size
    randomize(); // We want the dots to initially be random
  }
  
  void randomize() // Randomize the directions the dot will take
  {
    for(int i=0;i<directions.length;i++)
    {
      float angle = random(2*PI); // Generate random angle in the unit circle
      directions[i] = PVector.fromAngle(angle); // Get 2 values from that angle and set the current PVector to them
    }
  }
  
  Brain clone() // Clone the parent's brain
  {
    Brain cloned_brain = new Brain(directions.length); // Create cloned brain with the same amount of directions as the original
    for(int i=0;i<directions.length;i++)
    {
     cloned_brain.directions[i] = directions[i]; 
    }
    return cloned_brain;
  }
  
  void mutate()
  {
    float mutation_rate = 0.01; // Chance that a direction mutation change will occur
    for(int i=0;i<directions.length;i++) // Any direction has a change of a mutation
    {
      float threshold = random(1); // Generate random number
      if(threshold <= mutation_rate) // Mutation occurs
      {
        float angle = random(2*PI); // Generate random angle in the unit circle
        directions[i] = PVector.fromAngle(angle); // Get 2 values from that angle and set the current PVector to them
      }
    }    
  }
}
