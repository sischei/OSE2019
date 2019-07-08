#include <iostream>

using namespace std;
int main()

{
    int* pointer=new int[5];

    for (int i=0;i < 5; ++i){
        pointer[i]=i;
        cout << pointer[i]<< endl;
    }

    return 0;
}