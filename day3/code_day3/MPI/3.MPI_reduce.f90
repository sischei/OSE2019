!==============================================================!
!                                                             
!     a simple reduction with MPI_SUM                         
!
!==============================================================!

      program reduce

      use mpi 
      
      implicit none 
      
      integer :: rank, input, result, ierror

!----------------------------------------------------------------------        
      call MPI_Init(ierror)
      call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierror)

!----------------------------------------------------------------------        
      input = rank + 1

!----------------------------------------------------------------------              
!.....reduce the values of the different ranks in input to result of rank 0
!     with the operation sum (max, logical and)
      call MPI_Reduce(input, result, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD, ierror)

      if (rank .eq. 0) then
        write (*,*) 'result', result
      end if

      call MPI_Finalize(ierror)
!----------------------------------------------------------------------        
      end program reduce
!----------------------------------------------------------------------        
      
