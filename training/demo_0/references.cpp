
#include <iostream>
#include <new>
using namespace std;

int main ()
{



    float very_long_variabe_name_for_number=0;

    float& x=very_long_variabe_name_for_number;
    // x refers to the same memory location

    x=5; // sets very_long_variabe_name_for_number to 5;
    cout << " x: " << x << endl;

    float y=2;

    x=y; // sets very_long_variabe_name_for_number to 2;
    // does not set x to refer to y!
    cout << " x: " << x << endl;
    cout << " very_long_variabe_name_for_number: " << very_long_variabe_name_for_number << endl;


    
    return 0;
}