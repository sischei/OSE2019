#include <stdio.h>
#include <mpi.h>


int main (int argc, char *argv[])
{
    int my_rank, size;
    int sum;


    MPI_Init(&argc, &argv);

    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

    MPI_Comm_size(MPI_COMM_WORLD, &size);

    /* Compute sum of all ranks. */

    printf ("Rank %i:\tSum = %i\n", my_rank, sum);

    MPI_Finalize();
    return 0;
}
