/* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 * main.cpp
 * 
 * In this file, we perform and time Value Function Iterations. 
 * Furthermore, we store the results of certain 
 * iterations in text files. We end by computing the time it takes 
 * to write the results of a single iteration. 
 * 
 * Simon Scheidegger
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/ 

#include <iostream>
#include <fstream>
#include "param.hpp"
#include "econ.hpp"
#include "../eigen/Eigen/Dense"
#include <time.h>
#include <stdio.h>

using namespace Eigen;
using namespace std;

int main(int argc, const char * argv[]) {
    
    
    // timestamp variable
    clock_t tStart;
    
    // We create two matrices, ValOld and ValNew, to represent the old
    // and new value functions in value function iteration.
    MatrixXd ValOld(nk, ntheta);
    MatrixXd ValNew(nk, ntheta);
    
    /* We create Policy matrix, which will store the optimal policies corresponding 
     to each (nk, ntheta)combination*/
    MatrixXd Policy(nk, ntheta);
    
    /* Matrix for storing Data in desired format. 
    This matrix will be used to store the results of the iterations in text files.*/
    MatrixXd Display(nk, nout);
    
    // Unit for Printing Data to text files
    ofstream output;
    
    // Dummy Variable used for storing the return value of scanf (otherwise, we get compiler warnings)
    int dumm;
    
    /*
     ValOld and Policy are set equal to the Value and Policy functions stored during the numstart iteration.
     If numstart is equal to zero, they are simply set equal to zero matrices.
     */
    if (numstart==0) {
        ValOld=MatrixXd::Zero(nk, ntheta);
        ValNew=MatrixXd::Zero(nk, ntheta);
        Policy=MatrixXd::Zero(nk, ntheta);
    }
    
    // Extract Value and Policy functions from the corresponding text files.
    else {
        float f,g;  // Variables that will store the values of the value and policy function, respectively.
        FILE * pFile;   // Pointer to the text file
        
        for (int j=0; j<ntheta; j++) {
            char filename_dummy[100];
            sprintf(filename_dummy,"%s%.2f%s%d%s", "results/theta_" ,thetagrid(j),"_", numstart,".txt");
            pFile=fopen(filename_dummy, "r+");
            
            dumm=fscanf(pFile, "%*s %*s %*s"); // Dump the initial row consisting of strings describing the columns of the data file.
            
            // Dump the value of the first column (corresponding to the kgrid) and extract the values of the value and policy functions in the text file.
            for (int i=0; i<nk; i++) {
                dumm=fscanf (pFile, " %*f %f %f ", &f, &g);
                ValOld(i,j)=f;
                Policy(i,j)=g;
            }
            
            fclose(pFile);
        }
        
        ValNew=ValOld;

    }
    
    /* Declare the Value Function Iteration Function. This function takes the old value 
    function guess as an argument and returns a 2nk x ntheta matrix consisting of a concatenation 
    of the new value function guess and the policy matrix. More specifically, 
    the first nk x ntheta block of this matrix is the new value function guess whereas the last block is the Policy function.*/
    MatrixXd ValIt(MatrixXd ValOld);
    
    // Result is a (2nk x ntheta) matrix that will store the matrix returned by ValIt
    MatrixXd Result(2*nk, ntheta);

    
    /* We will now do Numits - numstart Value function iterations. 
     * We begin at iteration numstart and end at iteration Numits-1.
     */
    tStart = clock();
    for (int i=numstart; i<Numits; i++) {
        /* The ValNew resulting from the previous Value function iteration now becomes the ValOld of the current iteration. 
         */
        
        ValOld=ValNew;
        
        // Store Concatenated matrix returned by ValIt into Matrix Result
        Result=ValIt(ValOld);
        
        /* Extract Value Function and Policy Function and compute 
	 * the maximum difference between the old and new value functions
         */
        ValNew=Result.topLeftCorner(nk,ntheta);
        Policy=Result.bottomRightCorner(nk, ntheta);
        errmax=(ValNew-ValOld).array().abs().maxCoeff();
        printf("iteration %d max error %f \n", i+1, errmax);
        
        /* We store the results in a text file every 
	 * datafreq iterations. If datafreq=1, we store the results
         for every iteration.
         */
        if (i % datafreq==0) {
            
            /* For each theta state we create a textfile with three columns. 
	     * The first column is the kgrid of the problem, the second column 
	     * contains the corresponding values of the value function, 
	     * and the last column contains the corresponding optimal policies
             */
            
            for (int j=0; j<ntheta; j++) {
                // Create text file where we will store results
                char filename_dummy[100];
                sprintf(filename_dummy,"%s%.2f%s%d%s", "results/theta_" , thetagrid(j), "_", i+1, ".txt");
                output.open(filename_dummy);
                
                /* Store data as desired in Display and print results into the text file.
                 The display matrix stores the kgrid as its first column, the corresponding values
                 as its second column, and the optimal policies are its final column.
                 */
                
                Display<<kgrid, ValNew.col(j), Policy.col(j);
                output<<" kgrid "<<" ValNew "<< " Policy " << endl;
                output<<Display;
                output.close();
            }

        }
    }
    
    cout<<ValNew << endl;
    
    // End the timing of the iterations and print the time it took to do the iterations
    printf("Iterations took: %.2fs\n", (double)(clock() - tStart)/CLOCKS_PER_SEC);
    
    // Perform one last iteration so we can compute how much time it takes to write the results
    ValOld=ValNew;
    
    // Store Concatenated matrix returned by ValIt into Matrix Result
    Result=ValIt(ValOld);
    
    // Start Timing the Final Part (Writing Part)
    tStart = clock();
    
    // Extract Value Function and Policy Function and compute maximum difference between the old and new value functions
    
    ValNew=Result.topLeftCorner(nk,ntheta);
    errmax=(ValNew-ValOld).array().abs().maxCoeff();
    Policy=Result.bottomRightCorner(nk, ntheta);
    
    
    // Print kgrid and the corresponding Values and Policies into a text file for each theta
    for (int i=0; i<ntheta; i++) {
        // Create text file where we will store results
        char filename_dummy[100];
        sprintf(filename_dummy,"%s%.2f%s", "results/theta_" ,thetagrid(i),"_testing.txt");
        output.open(filename_dummy);
        
        // Store data as desired in Display and print results into the text file
        Display<<kgrid, ValNew.col(i), Policy.col(i);
        output<<" kgrid "<<" ValNew "<< " Policy " << endl;
        output<<Display;
        output.close();
    }
    
    // End timing
     printf("Final part (Writing Part) took: %.2fs\n", (double)(clock() - tStart)/CLOCKS_PER_SEC);
     cout << "Value function iteration completed" << endl;
     
    return 0;
 }
 
