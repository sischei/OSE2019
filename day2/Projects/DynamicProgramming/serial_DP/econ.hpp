/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 * econ.hpp
 *
 * This file delcares the economic functions that we will 
 * be using in the problem. It declares the gross output function, 
 * the utility function and the transition function. 
 * It also decleares the functions that 
 * construct the capital and theta grids.
 * 
 * Simon Scheidegger
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/ 

#ifndef econ_hpp
#define econ_hpp

#include <stdio.h>
#include "../eigen/Eigen/Dense"

using namespace Eigen;

// f(k, theta) is the gross output function
double f(double k, double theta);

// u is the utility function
double u(double c);

/* util makes utility -10^10 if consumption is negative; othwerwise, it returns u(c).
 This function makes sure we stay away from negative consumption values.
 */
VectorXd util(ArrayXd c);

/* Declare the Transition Function.
 For each theta, p(theta) returns the probability 
 distribution over the thetas given that we are at state theta.
 */
VectorXd p(double theta);

/* Given the number of capital states and level of 
discretization, the following constructs the kgrid
we will be working on*/
ArrayXd fill_kgrid();

/* Given the number of theta states and level of discretization, the following constructs the thetagrid
// we will be working on*/
ArrayXd fill_thetagrid();

#endif /* econ_hpp */
