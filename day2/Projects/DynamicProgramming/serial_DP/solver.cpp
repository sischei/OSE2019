/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 * solver.cpp
 * 
 * This defines the ValIt function, which takes the Old Value 
 * Function Guess and performs one Value function iteration.
 * 
 * Simon Scheidegger.
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/ 

#include <stdio.h>
#include "../eigen/Eigen/Dense"
#include "param.hpp"
#include "econ.hpp"

using namespace Eigen;


/* Discrete State Value Function Iteration 
 * 
 * The following defines the routine for one iteration of value function iteration, and produces the new 
 * value function. This is the Bellman equation 
 * In this problem, the control (knext here) is discrete, so maximization reduces to computing a list of 
 * values implied by all possible choices, and taking the maximum (max).*/

MatrixXd ValIt(MatrixXd ValOld) {
    
    // Initialize New Value Function Guess to Matrix of Zeros
    MatrixXd ValNew=MatrixXd::Zero(nk, ntheta);
    
    // Create Policy Function Matrix. This matrix stores the optimal
    // policy for each (k, theta) combination.
    // We Initialize it to a matrix of zeros.
    
    MatrixXd Policy=MatrixXd::Zero(nk, ntheta);
    
    // Create Index Variable for Storing the index of the optimal policy choice
    MatrixXd::Index maxIndex;
    
    // The following array will contain the consumption choices implied by each policy
    ArrayXd c(nk);
    
    // Temp will contain the list of values implied by each policy choice
    ArrayXd temp(nk);
    
    /*
     The following defines the economics part of the program. For each state (theta, k), 
     we compute the new value and policy functions. Since the problem is discrete, 
     the problem reduces to computing the values associated with each policy choice 
     and choosing the one that yields the highest value. 
     These policies and new values will then be part of our new value and policy function guesses.
     */


    for (int itheta=0; itheta<ntheta; itheta++) {
        
        /*
         Given the theta state, we now determine the new values and optimal policies corresponding to each
         capital state.  
         */
        
        for (int ik=0; ik<nk; ik++) {
            
            // Compute the consumption quantities implied by each policy choice
            c=f(kgrid(ik), thetagrid(itheta))-kgrid;
            
            // Compute the list of values implied implied by each policy choice
            temp=util(c) + beta*ValOld*p(thetagrid(itheta));
            
            /* Take the max of temp and store its location.
             The max is the new value corresponding to (ik, itheta).
             The location corresponds to the index of the optimal policy choice in kgrid.
             */
            ValNew(ik, itheta)=temp.maxCoeff(&maxIndex);
            
            Policy(ik, itheta)=kgrid(maxIndex);

        }
    }
    
    // Concatenate ValNew and Policy into a single (2nk x ntheta) matrix.
    MatrixXd result(2*nk, ntheta);
    
    result<< ValNew, Policy;
    
    //return the result matrix;
    return result;
}



