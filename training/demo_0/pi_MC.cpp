#include <iostream>
#include <cstdlib>      //defines rand(), srand(), RAND_MAX
#include <ctime>        //defines ctime() for random numbers
#include <cmath>        //defines math functions
using namespace std;
//the concept is we generate random numbers  considering a circle with origin (0,0) enclosed in square of 1 unit length .

// the points lying inside the cirle are considered to generate value of pi



//calculates the distance of the dart from the origin
double dist(double x, double y)
{
    double throwDist;
    throwDist = sqrt(x*x +y*y);  //Euclidean Distance Formula from point (0,0) i.e value of radius
    return throwDist;
}



//calculates pi using number of darts thrown in the circle vs all darts thrown
double pie(int numThrows, double a)
{
    double pieValue = a / numThrows;
    return pieValue;
}





int main()
{
    double coord_x, coord_y, test;
    srand(time(NULL));      //creates the seed time
    
    test = rand() / double(RAND_MAX);
    
    double throwDist;       //distance from the origin
  
    double a = 0;              //times a dart ends up inside the circle
    int numThrows;          //how many times to throw the dart
    cout<< "Enter how many time to throw the dart or number of points to consider: "<< endl;
    cin>> numThrows;

    //creates 2 random numbers 'n' times
    for(int i = 1; i <= numThrows; i++)
    {
        coord_x = (double)rand() / (RAND_MAX); //random no. for x- coordinate
        coord_y = (double)rand() / (RAND_MAX);  // random no for y coordinate
        throwDist = dist(coord_x, coord_y); //calculate distance from the center to current points
        
        //check if the dart is thrown inside the circle i.e radius is less than 1
        if(throwDist <= 1)
        {
            a++;
        }
    }
    
    double pieCalc =4* pie(numThrows, a); //

    cout<< "The value of PI is: " << pieCalc << endl;;
return 0;
}