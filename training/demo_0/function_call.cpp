#include <iostream>
using namespace std;

float square(float x) {
	return x*x;
}

int main() {
	cout << "Enter a number:\n";
	float x;
	cin >> x;
	cout << x << " " <<
	square(x) << "\n";
return 0;
}