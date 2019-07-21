/*==================================================
 * Purpose: A program to test MPI_Ssend and MPI_Recv
 * 
 * Purpose: A program to test MPI_Ssend and MPI_Recv
 * 
 *==================================================*/


#include <stdio.h>
#include <iostream>
#include <mpi.h>

using namespace std;

int main(int argc, char **argv)
{

    int rank, size;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);
    MPI_Comm_size(MPI_COMM_WORLD,&size);

    //the example should only be run with 2 procs, else abort
    if (size != 2) {
      if (rank == 0) {
	cout << "please run this with 2 processors "<<endl;
      }
      MPI_Finalize();
      return 0;
    }
    
    int count;
    if (rank == 0) {
      // initialize count on process 0
      count = 0;
    }
    
    for (int i=0; i<42; i++){
       /* Process 0 sends a message (ping) to process 1.
	* After receiving the message, process 1 sends a message (pong) to process 0.*/
     if (rank == 0) {
       MPI_Send(&count, 1, MPI_INT, 1, 0, MPI_COMM_WORLD); //send "count" to rank 1
       MPI_Recv(&count, 1, MPI_INT, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE); //receive it back
       count = count + 1;
      }
      if (rank == 1) {
       MPI_Recv(&count, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
       MPI_Send(&count, 1, MPI_INT, 0, 0, MPI_COMM_WORLD); 
      } 
    }
    
    if (rank == 0) {
      cout << "Round trip count = " << count << endl; 
    }
    MPI_Finalize();
    return 0;
    
}