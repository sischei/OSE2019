#include <iostream>
using std::cout;

void swap1 (int a, int b) { int t=a; a=b; b=t; }
void swap2 (int& a, int& b) { int t=a; a=b; b=t;}
void swap3 (const int & a, const int& b) { int t=a; a=b; b=t;}
void swap4 (int *a, int *b) { int *t=a; a=b; b=t;}
void swap5 (int* a, int* b) {int t=*a; *a=*b; *b=t;}

int main() {
// Which will compile? What is the effect of:
{ int a=1; int b=2; swap1(a,b); cout << a << " " << b << "\n";}
{ int a=1; int b=2; swap2(a,b); cout << a << " " << b << "\n";} 
{ int a=1; int b=2; swap3(a,b); cout << a << " " << b << "\n";} 
{ int a=1; int b=2; swap4(&a,&b); cout << a << " " << b << "\n";} 
{ int a=1; int b=2; swap5(&a,&b); cout << a << " " << b << "\n";}

return 0;
}
