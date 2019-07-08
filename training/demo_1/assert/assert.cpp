#include <iostream>
#include <cmath>
#include <cassert>

double checked_sqrt(double x)
{
  assert(x >= 0.);
  return sqrt(x);
}


int main()
{
  double x;
  std::cout << "Give me a number: x = ";
  std::cin >> x;
  std::cout << "sqrt(x) = " << checked_sqrt(x) << "\n";
}

