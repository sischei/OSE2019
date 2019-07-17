/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 * param.hpp
 * 
 * This file declares the parameters of the problem. It 
 * declares the preference parameters, the state space, the 
 * level of discretization, and the number of iterations. 
 * It also declares parameters useful for 
 * formatting the output files of the program.
 * 
 * Simon Scheidegger
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/ 

#ifndef param_hpp
#define param_hpp

#include <stdio.h>
#include "../eigen/Eigen/Dense"

using namespace Eigen;

// Preference Parameters
extern double alpha;
extern double gamm;
extern double beta;

// Capital Stock Interval

// Minimum and Maximum Capital Stock
extern double kmin;
extern double kmax;

// Choose nk, the number of capital stocks, and kappa, the discretization level
extern int nk;
extern double kappa;


// Create Vector of Productivity States
extern int ntheta;
extern double theta_min;
extern double theta_step;

// grids
extern ArrayXd kgrid;
extern ArrayXd thetagrid;

// Number of Iterations
extern int numstart;
extern int Numits;

// Maximum error
extern double errmax;

// Number of Columns for output
extern int nout;

// Frequency with which data will be printed
extern int datafreq;

#endif /* param_hpp */
