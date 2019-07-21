/*==============================================================
!                                                             
!     split the communicator                        
!     adjusted from:
!     https://computing.llnl.gov/tutorials/mpi/#Group_Management_Routines
!
!==============================================================*/

   #include <stdio.h>
   #include <iostream>
   #include "mpi.h"

   #define NPROCS 8

   using namespace std;
   
   main(int argc, char *argv[])  {
     
   int        rank, new_rank, sendbuf, recvbuf, numtasks,
              ranks1[4]={0,1,2,3}, ranks2[4]={4,5,6,7};
   MPI_Group  orig_group, new_group;   // required variables
   MPI_Comm   new_comm;   // required variable

   MPI_Init(&argc,&argv);
   MPI_Comm_rank(MPI_COMM_WORLD, &rank);
   MPI_Comm_size(MPI_COMM_WORLD, &numtasks);

   if (numtasks != NPROCS) {
     cout << "Must specify 8 MPI processes = " << NPROCS << " !! Terminating "<< endl;
     MPI_Finalize();
     return 0;
     }

   sendbuf = rank;

   // extract the original group handle
   MPI_Comm_group(MPI_COMM_WORLD, &orig_group);

   //  divide tasks into two distinct groups based upon rank
   if (rank < NPROCS/2) {
     MPI_Group_incl(orig_group, NPROCS/2, ranks1, &new_group);
     }
   else {
     MPI_Group_incl(orig_group, NPROCS/2, ranks2, &new_group);
     }

   // create new new communicator and then perform collective communications
   MPI_Comm_create(MPI_COMM_WORLD, new_group, &new_comm);
   MPI_Allreduce(&sendbuf, &recvbuf, 1, MPI_INT, MPI_SUM, new_comm);

   // get rank in new group
   MPI_Group_rank (new_group, &new_rank);
   cout << "rank= " << rank << " newrank= "<< new_rank << " recvbuf= " <<recvbuf << endl;

   MPI_Finalize();
   }

     