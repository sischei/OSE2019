#include <iostream>
#include <cmath>

using namespace std;

float square(float x, unsigned int n = 2) {
	return pow(x, n);
}
    int main()
    {
        
        float x_in = 1.2;
 	cout << square(x_in,3) << endl; // third power of 1.2
 	cout << square(3,2)    << endl; // second power of 3
 	cout << square(3)      << endl; // return 3^1
         
        return 0;
    }