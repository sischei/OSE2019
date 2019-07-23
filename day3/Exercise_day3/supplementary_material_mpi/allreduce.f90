!----------------------------------------------------------------------                                                               
!  a grogram to demonstrate a reduce to all                              
!----------------------------------------------------------------------   

      program allreduce
      
      use mpi

      implicit none

      integer :: ierror, my_rank
      integer :: sum

!----------------------------------------------------------------------         
      call MPI_Init(ierror)
      call MPI_Comm_rank(MPI_COMM_WORLD, my_rank, ierror)

!.....TBD calculate sum of all ranks
      write(*,*) "Rank", my_rank, ": Sum =", sum

      call MPI_Finalize(ierror)

!----------------------------------------------------------------------         
      end program allreduce
!----------------------------------------------------------------------   
      
