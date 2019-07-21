!======================================================================      
!      
!     MPI example: Hello World with MPI
!
!     Note: All Fortran MPI calls take an INTENT(OUT) argument, here
!     called ierror, which transports information about the success of 
!     the MPI operation to the user code, a value of MPI_SUCCESS 
!     meaning that there were no errors.
!
!======================================================================   

      program hello_world_mpi
      
      use mpi

      implicit none

      integer :: ierror, rank, size

!----------------------------------------------------------------------      
      call MPI_INIT(ierror)   !start MPI

!----------------------------------------------------------------------      
!.....Get the rank of each process
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)

!----------------------------------------------------------------------      
!.....Get the size of the communicator
      call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)

!----------------------------------------------------------------------      
!.....Write code such that every process writes its rank and the 
!.....size of the communicator, but only process 0 prints "hello world"
      if (rank .eq. 0) then
        write(*,*) 'Hello world!'
      end if

!----------------------------------------------------------------------
!.....every process does something 
      write(*,*) 'I am process', rank, ' out of', size

!----------------------------------------------------------------------
      call MPI_FINALIZE(ierror)  !finish MPI

!----------------------------------------------------------------------      
      end program hello_world_mpi
!----------------------------------------------------------------------

      