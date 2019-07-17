#include <iostream>
int main()
{
        using namespace std;  
        cout << "Hello user!"; //no std:: prefix is needed!
        cout << "Enter a number: "; // ask user for a number
        int x = 0;
        cin >> x; // read number from console and store it in x
        cout << "You entered " << x << endl;
        return 0;
}