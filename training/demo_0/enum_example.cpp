//example program to demonstrate working 
// of enum in C 
#include <iostream>
using namespace std;

enum year{Jan, Feb, Mar, Apr, May, Jun, Jul,  
          Aug, Sep, Oct, Nov, Dec}; 
  
          
int main() 
{ 
   int i; 
   for (i=Jan; i<=Dec; i++)       
      cout << i << endl;
        
   return 0; 
} 