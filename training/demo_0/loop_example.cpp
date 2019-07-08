#include <iostream>
using namespace std;
int main()
{
	cout << "Enter a number: ";
	unsigned int n;
	cin >> n;
	for (int i=1;i<=n;++i)
		cout << i << "\n";

	int i=0;
	while (i<n)
		cout << ++i << "\n";
        
        i=1;
        do
            cout << i++ << "\n";
        while (i<=n);

        i=1;
        while (true) {
        if(i>n)
            break;
        cout << i++ << "\n";
    }
}