!======================================================================   
!  
!     example program to demonstrate Bcast
!
!======================================================================   

      program bcast

      use MPI
      
      character(12) :: message 
      integer rank
      
      integer, parameter :: root = 0 !define the root process 
      integer :: bcast_param
      
      call MPI_INIT(ierr)

      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) !identify the rank
      
      if (rank .eq. root) then 
        bcast_param = 5
      else
        bcast_param = 0
      endif 
      
      call MPI_BCAST(bcast_param, 1, MPI_INT, root, &
         MPI_COMM_WORLD, ierr)
         
      write(*,*) "process", rank, ":", bcast_param
      
      call MPI_FINALIZE(ierr)
      
!======================================================================    
      end program bcast
!======================================================================    
      