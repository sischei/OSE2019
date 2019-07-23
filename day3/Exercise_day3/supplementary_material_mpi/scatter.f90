!---------------------------------------------------------------------
!      program to demonstrate MPI_Scatter                                  
!---------------------------------------------------------------------  

      program scatter_number
   
      use mpi 
   
      implicit none
 
      integer :: i, rank, size, senddata(10), receivedata, ierror

!----------------------------------------------------------------------      
      call MPI_Init(ierror)
      call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierror)
      call MPI_Comm_size(MPI_COMM_WORLD, size, ierror)
!----------------------------------------------------------------------   

      if (size .gt. 10) then
        if (rank == 0) then
          write(*,*) "do not use more than 10 processors"
          call MPI_Finalize(ierror)
        end if
      end if
      
!----------------------------------------------------------------------         
      if (rank  == 0) then
        do i = 1, size, 1
          write(*,*) 'enter a value:'
          read(*,*) senddata(i)
        end do
      end if

!.....scatter the value of senddata of rank 0 to receivedata of all ranks

      write (*,*) "I am rank", rank, "and the value is", receivedata

      call MPI_Finalize(ierror)
!----------------------------------------------------------------------   
      end program scatter_number
!---------------------------------------------------------------------- 