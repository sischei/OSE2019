/*==============================================================
                                                             
     a simple reduction with MPI_SUM                         

==============================================================*/

#include <stdio.h>
#include <iostream>
#include "mpi.h"

using namespace std;

int main(int argc, char *argv[]) {
    int rank, input, result;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    
    
    input=rank+1;

    MPI_Reduce(&input, &result, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

    if (rank==0){
      cout << "Rank 0 says: result is "<<  result << endl;
    }
    
    MPI_Finalize();
    return 0;
}