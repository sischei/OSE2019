#include <iostream>
using namespace std;

    void f(int x) {
        x++; // increments x but not the variable of the calling program
        cout << "function input "  << x << endl;
    }

    int main() {
        int a= 11;
        f(a);
        cout << "main "  << a  << endl; // is still 1
        
        return 0;
    }