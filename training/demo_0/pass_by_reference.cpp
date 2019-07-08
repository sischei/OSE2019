#include <iostream>
using namespace std;
   
   
   void increment(int& n) {
        cout << "function -- input value "  << n << endl;
        n++;
        cout << "function -- incremented value "  << n << endl;

    }

    int main() {
        
        int x=1; 
        
        increment(x); // x now 2
        cout << "main -- value "  << x << endl;
        
        
        //increment(5); // will not compile since 5 is    literal constant!
        
        return 0;
    }