// #include <iostream>
#include <random>
#include <stdio.h>


//generate random numbers in [0,1]
#include <iostream>
using namespace std;

int main()
{
  
//!.....uniform distributed [0..1]	
	unsigned seed_unif1 = 3;
	std::default_random_engine generator_unif(seed_unif1);
	std::uniform_real_distribution<double> distribution_unif(0.0,1.0);

	int No_random_numbers = 10;
	double rand_number;
	
	
//!.....generate No_random_numbers 		
	for(int numbers = 1; numbers <=No_random_numbers; numbers++)
	{
	  rand_number = distribution_unif(generator_unif);
	  cout << "random number i = "  << numbers << " has value " << rand_number << endl;  
	}
	
	
  return 0;
}


