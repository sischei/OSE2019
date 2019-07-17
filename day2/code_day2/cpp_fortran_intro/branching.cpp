#include <iostream>
// function that returns true if x and y are equal, false otherwise
bool isEqual(int x, int y)  
{
    return (x == y); // operator== returns true if x equals y, and false otherwise
}
int main()
{
    using namespace std;
    cout << "Enter an integer: ";
    int x;
    cin >> x;
 
    cout << "Enter another integer: ";
    int y;
    cin >> y;
 
    bool equal = isEqual(x, y);
    if (equal)
        cout << x << " and " << y << " are equal" << endl;
    else
        cout << x << " and " << y << " are not equal" << endl;
    return 0;
}