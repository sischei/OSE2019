!----------------------------------------------------------------------   
!     program to demonstrate MPI_Bcast
!----------------------------------------------------------------------   

      use mpi 
 
      implicit none
 
      integer :: rank, data, ierror

!----------------------------------------------------------------------         
      call MPI_Init(ierror)
      call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierror)

      if (rank == 0) then
        write(*,*) 'enter a value:'
        read(*,*) data
      end if

!.....broadcast the value of data of rank 0 to all ranks

      write(*,*) "I am rank", rank, "and the value is", data

      call MPI_Finalize(ierror)
!----------------------------------------------------------------------   
      end program broadcast
!----------------------------------------------------------------------   