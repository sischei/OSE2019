#include <iostream>

using namespace std;
int main()

{
    int *p; // pointer to an integer

    //Are initialized using the & operator
    int i=3;
    p =&i; // & takes the address of a variable

    //Are dereferenced with the * operator
    *p = 1; // sets i=1
    cout << " *p = " << *p <<" p = "<< p <<" i = "<<i<< endl;
    
    //Can be dangerous to use
    *p = 258; // now messes up everything, can crash
    
}