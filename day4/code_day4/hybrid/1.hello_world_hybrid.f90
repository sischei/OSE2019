!======================================================================      
!      
!     MPI example: Hello World with MPI and OpenMP
!
!======================================================================   

      program hello_world_hybrid
      
      use mpi

      use omp_lib      !module with API declarations      
      
      implicit none

      integer :: ierror, rank, size  !MPI variables

      integer :: tid   !thread ID for OpenMP
      
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
        write(*,*) 'Hello world from rank 0!'
      end if

!----------------------------------------------------------------------
!.....every process does something 
      write(*,*) "=== shared memory parallel section on every MPI process"
      write(*,*) '=== here we are on rank', rank
      
!$omp parallel private(tid)    
!.....get thead ID
      tid = omp_get_thread_num();

!.....write a personalized message from this thread and process
!       write(*,*) 'I am process', rank, ' out of', size
      write(*,*) 'hello world from thread ', omp_get_thread_num() + 1, &
     &           ' of ', omp_get_num_threads(), 'and rank', rank

!.....section only executed by master
      if(tid .eq. 0 ) then
        write(*,*) 'hello world from OpenMP master thread with TID = ' &
     &              , tid, ' and rank', rank
      end if
 
!....All threads join master thread and disband 
!$omp end parallel      

!----------------------------------------------------------------------
      call MPI_FINALIZE(ierror)  !finish MPI

!----------------------------------------------------------------------      
      end program hello_world_hybrid
!----------------------------------------------------------------------

      