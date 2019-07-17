/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 * econ.cpp
 * 
 * This file defines the economic functions that we will be 
 * using in the problem. This file defines the gross output function, 
 * the utility function and the transition matrix. 
 * Moreover, it also defines the functions that construct 
 * the capital and theta grids.
 * 
 * Simon Scheidegger
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/ 

#include "param.hpp"

// f(k, theta) is the gross output function
double f(double k, double theta) {
    double f=k+theta*((1-beta)*pow(k,alpha))/(beta*alpha);
    return f;
}

/* u is the utility function. The function makes utility -10^10 if consumption is negative, making
 sure we stay away from negative consumption values.
 */
double u(double c) {
    double u= c > 0.001 ?  pow(c, 1-gamm)/(1-gamm) : -pow(10, 10);
    return u;
}

/* The following function vectorizes the utility function. 
 * That is, it receives a consumption vector 
 * and returns a vector of utilities 
 */
VectorXd util(ArrayXd c) {
    VectorXd util(c.size());
    
    for (int i=0; i<c.size(); i++) {
        util(i)= u(c(i));
    }
    return util;
}

/* Define Transition Function. 
 * For each theta, p(theta) returns the 
 * probability distribution over the thetas given that we are at state theta.
 */

VectorXd p(double theta) {
    VectorXd p=(1.0/ntheta)*VectorXd::Ones(ntheta);
    return p;
}


/* Given the number of capital states and 
 * level of discretization, the following constructs the kgrid
 * we will be working on*/
ArrayXd fill_kgrid() {
    ArrayXd kgrid(nk);
    for (int i=0; i<nk; i++) {
        kgrid(i)=kmin + i*kappa;
    }
    return kgrid;
}


/* Given the number of theta states and level of discretization, 
 * the following constructs the thetagrid we will be working on*/
ArrayXd fill_thetagrid() {
    ArrayXd thetagrid(ntheta);
    for (int i=0; i<ntheta; i++) {
        thetagrid(i)=theta_min+i*theta_step;
    }
    return thetagrid;
}


