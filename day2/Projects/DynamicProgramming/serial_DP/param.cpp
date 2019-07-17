/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 * param.cpp
 * 
 * This file defines the parameters of the problem. 
 * It defines the preference parameters, 
 * the state space, the level of discretization, 
 * and the number of iterations. 
 * It also defines parameters useful for formatting the output files of the program.
 * 
 * Simon Scheidegger
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/ 

#include "econ.hpp"

using namespace Eigen;

// Preference Parameters
double alpha = 0.25;
double gamm  = 5.0;
double beta  = 0.9;

// Capital Stock Interval
double kmin = 0.85; //minimum capital
double kmax = 1.15; //max. capital

// Choose nk, the number of capital stocks, and kappa, the discretization level
int nk  =  31;
double kappa  =  (kmax-kmin)/(nk-1.0);

// Number of theta states and the minimum and maximum theta values
int ntheta = 5;
double theta_min  = 1-10.0/100;
double theta_step = 5.0/100;

// Capital and Theta grids
ArrayXd kgrid=fill_kgrid();
ArrayXd thetagrid=fill_thetagrid();

// Number of Iterations
int numstart = 0; // start iterating at this timestep
int Numits = 10;   // stop  iterating at this timestep

// Maximum difference between succesive Value Function Iterates (initialized to 0)
double errmax = 0;

// Number of Columns for output
int nout = 3;

// Frequency with which data will be printed, e.g. 1=every timestep, 10=every ten iteration steps
int datafreq = 1;


